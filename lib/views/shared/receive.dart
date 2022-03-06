import 'dart:io';
import 'dart:math';

import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/shared/progress.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_wormhole_gui/views/shared/util.dart';
import 'package:path_provider/path_provider.dart';

enum ReceiveScreenStates {
  FileReceived,
  ReceiveError,
  FileReceiving,
  ReceiveConfirmation,
  Initial,
}

abstract class ReceiveShared<T extends ReceiveState> extends State<T> {
  String? _code;
  late int fileSize;
  late String fileName;

  ReceiveScreenStates currentState = ReceiveScreenStates.Initial;
  SharedPreferences? prefs;
  final Config config;
  String? defaultPathForPlatform;
  String? error;
  String? errorMessage;
  dynamic stacktrace;

  late final TextEditingController controller = new TextEditingController();
  late final Client client = Client(config);
  late void Function() acceptDownload;
  late void Function() rejectDownload;

  String? get path {
    final path = prefs?.get(PATH);

    if (path is String?) {
      return path;
    }

    return defaultPathForPlatform;
  }

  ReceiveShared(this.config) {
    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
    });

    if (Platform.isAndroid) {
      defaultPathForPlatform = DOWNLOADS_FOLDER_PATH;
    } else {
      getDownloadsDirectory().then((downloadsDir) {
        setState(() {
          defaultPathForPlatform = downloadsDir?.path;
        });
      });
    }
  }

  late ProgressShared progress = ProgressShared(setState, () {
    currentState = ReceiveScreenStates.FileReceiving;
  });

  void codeChanged(String code) {
    setState(() {
      _code = code;
    });
  }

  static String _tempPath(String prefix) {
    final r = Random();
    int suffix = r.nextInt(1 << 32);
    while (File("$prefix.$suffix").existsSync()) {
      suffix = r.nextInt(1 << 32);
    }

    return "$prefix.$suffix";
  }

  String nonExistingPathFor(String path) {
    if (File(path).existsSync()) {
      int i = 1;
      String baseName = path.split(Platform.pathSeparator).last;
      String directory = File(path).parent.path;
      String? extension;
      if (baseName.contains(".")) {
        final parts = baseName.split(".");
        baseName = parts.take(parts.length - 1).join("");
        extension = parts.last;
      }
      String nextPath() => extension != null
          ? "$directory/$baseName($i).$extension"
          : "$directory/$baseName($i)";
      while (File(nextPath()).existsSync()) {
        i++;
      }

      return "${nextPath()}";
    } else {
      return path;
    }
  }

  Future<ReceiveFileResult> receive() async {
    return canWriteToFile().then((permissionStatus) async {
      if (permissionStatus == PermissionStatus.granted) {
        late final File tempFile;

        return client.recvFile(_code!, progress.progressHandler).then((result) {
          result.done.then((value) {
            this.setState(() {
              currentState = ReceiveScreenStates.FileReceived;
            });
            return tempFile.rename(
                nonExistingPathFor("$path/${result.pendingDownload.fileName}"));
          }, onError: (error, stacktrace) {
            this.setState(() {
              this.currentState = ReceiveScreenStates.ReceiveError;
              this.error = error.toString();
              this.stacktrace = stacktrace;
              this.errorMessage = "Failed to receive file: error.toString()";
              print("Error $error $stacktrace");
            });

            return tempFile;
          });

          this.setState(() {
            currentState = ReceiveScreenStates.ReceiveConfirmation;
            acceptDownload = () {
              controller.text = '';
              tempFile =
                  File(_tempPath("$path/${result.pendingDownload.fileName}"));
              result.pendingDownload.accept(tempFile);
              this.setState(() {
                currentState = ReceiveScreenStates.FileReceiving;
              });
            };
            rejectDownload = () {
              result.pendingDownload.reject();
              this.setState(() {
                currentState = ReceiveScreenStates.Initial;
              });
            };
            fileName = result.pendingDownload.fileName;
            fileSize = result.pendingDownload.size;
          });

          return result;
        });
      } else {
        return Future.error(Exception("Permission denied"));
      }
    });
  }

  Widget widgetByState(
      Widget Function() receivingDone,
      Widget Function() receiveError,
      Widget Function() receiveProgress,
      Widget Function() enterCodeUI,
      Widget Function() receiveConfirmation) {
    switch (currentState) {
      case ReceiveScreenStates.Initial:
        return enterCodeUI();
      case ReceiveScreenStates.ReceiveError:
        return receiveError();
      case ReceiveScreenStates.ReceiveConfirmation:
        return receiveConfirmation();
      case ReceiveScreenStates.FileReceived:
        return receivingDone();
      case ReceiveScreenStates.FileReceiving:
        return receiveProgress();
    }
  }

  Widget build(BuildContext context);
}

abstract class ReceiveState extends StatefulWidget {
  final Config config;

  ReceiveState(this.config, {Key? key}) : super(key: key);
}
