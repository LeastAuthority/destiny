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
  TransferRejected,
  TransferCancelled,
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
  late bool isRequestingConnection = false;

  ReceiveScreenStates currentState = ReceiveScreenStates.Initial;
  SharedPreferences? prefs;
  final Config config;
  late final String? defaultPathForPlatform;
  String? error;
  String? errorMessage;
  StackTrace? stacktrace;

  late final TextEditingController controller = new TextEditingController();
  late final Client client = Client(config);

  void Function() failWith(String errorMessage) {
    return () {
      throw Exception(errorMessage);
    };
  }

  late void Function() acceptDownload =
      failWith("No accept download function set");
  late void Function() rejectDownload =
      failWith("No reject download function set");

  late CancelFunc cancelFunc = failWith("No cancel transfer function set");

  String? get path {
    final path = prefs?.get(PATH);

    if (path != null && path is String) {
      return path;
    }

    return defaultPathForPlatform;
  }

  ReceiveShared(this.config) {
    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
    });

    if (Platform.isAndroid) {
      defaultPathForPlatform = ANDROID_DOWNLOADS_FOLDER_PATH;
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

  Future<ReceiveFileResult> receive() async {
    return await canWriteToFile().then((permissionStatus) async {
      if (permissionStatus == PermissionStatus.granted) {
        late final File tempFile;
        this.setState(() {
          isRequestingConnection = true;
        });
        return client.recvFile(_code!, progress.progressHandler).then((result) {
          result.done.then((value) {
            this.setState(() {
              currentState = ReceiveScreenStates.FileReceived;
            });
            if (!Platform.isWindows) {
              tempFile.rename(nonExistingPathFor(
                  "$path/${result.pendingDownload.fileName}"));
            } else {
              tempFile.copySync(nonExistingPathFor(
                  "$path/${result.pendingDownload.fileName}"));
              tempFile.deleteSync();
            }
          }, onError: (error, stacktrace) {
            this.setState(() {
              this.currentState = ReceiveScreenStates.ReceiveError;
              this.error = error.toString();
              this.stacktrace = stacktrace as StackTrace;
              this.errorMessage = "Failed to receive file: $error";
              print("Error receiving file\n$error\n$stacktrace");

              if (error is ClientError) {
                switch (error.errorCode) {
                  case ErrCodeTransferRejected:
                    this.currentState = ReceiveScreenStates.TransferRejected;
                    break;
                  case ErrCodeTransferCancelled:
                    this.currentState = ReceiveScreenStates.TransferCancelled;
                    break;
                }
              }
            });

            throw error;
          });

          this.setState(() {
            currentState = ReceiveScreenStates.ReceiveConfirmation;
            acceptDownload = () {
              controller.text = '';
              tempFile =
                  File(_tempPath("$path/${result.pendingDownload.fileName}"));
              var cancelFunc = result.pendingDownload.accept(tempFile);
              this.setState(() {
                currentState = ReceiveScreenStates.FileReceiving;
                this.cancelFunc = cancelFunc;
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
      Widget Function() receiveConfirmation,
      Widget Function() transferCancelled,
      Widget Function() transferRejected) {
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
      case ReceiveScreenStates.TransferRejected:
        return transferRejected();
      case ReceiveScreenStates.TransferCancelled:
        return transferCancelled();
    }
  }

  Widget build(BuildContext context);
}

abstract class ReceiveState extends StatefulWidget {
  final Config config;

  ReceiveState(this.config, {Key? key}) : super(key: key);
}
