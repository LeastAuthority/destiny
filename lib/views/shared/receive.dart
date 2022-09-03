import 'dart:io';
import 'dart:math';

import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/views/shared/progress.dart';
import 'package:destiny/views/shared/util.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ReceiveScreenStates {
  FileReceived,
  ReceiveError,
  FileReceiving,
  ReceiveConfirmation,
  Initial,
}

class ReceiveSharedState extends ChangeNotifier {
  String? _code;

  PendingDownload? pendingDownload;

  int? get fileSize => pendingDownload?.size;
  String? get fileName => pendingDownload?.fileName;

  late bool isRequestingConnection = false;

  ReceiveScreenStates currentState = ReceiveScreenStates.Initial;
  SharedPreferences? prefs;
  final Config config;
  late final String? defaultPathForPlatform;
  String? error;
  String? errorMessage;
  String? errorTitle;
  String? saveAsPath;
  bool selectingFolder = false;

  late final TextEditingController controller = new TextEditingController();
  late final Client client = Client(config);

  void Function() failWith(String errorMessage) {
    return () {
      throw Exception(errorMessage);
    };
  }

  void setState(void Function() change) {
    change();
    notifyListeners();
  }

  late void Function() acceptDownload =
      failWith("No accept download function set");
  late void Function() rejectDownload =
      failWith("No reject download function set");

  late CancelFunc cancelFunc = failWith("No cancel transfer function set");

  String? get path {
    final path = prefs?.get(PATH);
    if (saveAsPath != null) {
      return saveAsPath;
    }
    if (path != null && path is String) {
      return path;
    }

    return defaultPathForPlatform;
  }

  void reset() {
    setState(() {
      _code = null;
      controller.text = '';
      pendingDownload = null;
      isRequestingConnection = false;
      currentState = ReceiveScreenStates.Initial;
      error = null;
      errorMessage = null;
      errorTitle = null;
      saveAsPath = null;
      progress = ProgressSharedState(setState, () {
        currentState = ReceiveScreenStates.FileReceiving;
      });
      cancelFunc = failWith("No cancel transfer function set");
    });
  }

  ReceiveSharedState(this.config) {
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

  late ProgressSharedState progress = ProgressSharedState(setState, () {
    currentState = ReceiveScreenStates.FileReceiving;
  });

  void codeChanged(String code) {
    setState(() {
      _code = code;
      isRequestingConnection = false;
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

  void defaultErrorHandler(Object error) {
    this.setState(() {
      this.currentState = ReceiveScreenStates.ReceiveError;
      this.error = '';
      this.errorMessage = error.toString();
      this.errorTitle = SOMETHING_WENT_WRONG;
      print("$ERROR_RECEIVING_FILE\n$error");

      if (error is ClientError) {
        switch (error.errorCode) {
          case ErrCodeTransferRejected:
            this.errorTitle = TRANSFER_CANCELLED;
            this.error = YOU_HAVE_CANCELLED_THE_TRANSFER;
            break;
          case ErrCodeTransferCancelled:
            this.errorTitle = TRANSFER_CANCELLED;
            this.error = YOU_HAVE_CANCELLED_THE_TRANSFER;
            break;
          case ErrCodeTransferCancelledBySender:
            this.errorTitle = TRANSFER_CANCELLED_INTERRUPTED;
            this.error = EITHER_THE_TRANSFER_WAS_CANCELLED_BY_SENDER;
            break;
          case ErrCodeWrongCode:
            this.errorTitle = OOPS;
            this.error = SOMETHING_WENT_WRONG_POSSIBLY;
            break;
          case ErrCodeReceiveFileError:
            this.errorTitle = SOMETHING_WENT_WRONG;
            // TODO: map error to user friendly name (case invalid nameplate)
            break;
          case ErrCodeReceiveTextError:
            this.errorTitle = SOMETHING_WENT_WRONG;
            // TODO: map error to user friendly name
            break;
          case ErrCodeConnectionRefused:
            this.errorTitle = OOPS;
            this.error = ERR_CONNECTION_REFUSED;
            break;
          default:
            this.errorTitle = SOMETHING_WENT_WRONG;
            // TODO: map error to user friendly name
            break;
        }
      }
    });

    throw error;
  }

  Future<ReceiveFileResult> receive() async {
    late final File tempFile;
    this.setState(() {
      isRequestingConnection = true;
    });
    return client.recvFile(_code!, progress.progressHandler).then((result) {
      result.done.then((value) async {
        this.setState(() {
          currentState = ReceiveScreenStates.FileReceived;
        });
        await tempFile.rename(nonExistingPathFor("$path" +
            Platform.pathSeparator +
            "${result.pendingDownload.fileName}"));
      }, onError: defaultErrorHandler);

      this.setState(() {
        currentState = ReceiveScreenStates.ReceiveConfirmation;
        acceptDownload = () {
          controller.text = '';
          tempFile = File(_tempPath("$path" +
              Platform.pathSeparator +
              "${result.pendingDownload.fileName}"));
          var cancelFunc =
              result.pendingDownload.accept(tempFile.writeOnlyFile());
          this.setState(() {
            currentState = ReceiveScreenStates.FileReceiving;
            this.cancelFunc = cancelFunc;
          });
        };
        rejectDownload = () {
          result.pendingDownload.reject();
          reset();
        };
        pendingDownload = result.pendingDownload;
      });

      return result;
    }, onError: defaultErrorHandler);
  }

  void selectSaveDestination() async {
    if (selectingFolder) return;
    try {
      this.setState(() {
        selectingFolder = true;
      });
      String? directory = await FilePicker.platform
          .getDirectoryPath(initialDirectory: prefs?.getString(PATH));
      if (directory == null) {
        return;
      }
      if (await canWriteToDirectory(directory)) {
        setState(() {
          saveAsPath = "$directory${Platform.pathSeparator}";
          acceptDownload();
        });
      } else {
        final error =
            Exception("Permission denied. Could not write to ${path!}");
        defaultErrorHandler(error);
        return Future.error(error);
      }
    } finally {
      this.setState(() {
        selectingFolder = false;
      });
    }
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
}
