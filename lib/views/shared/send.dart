import 'dart:async';
import 'dart:io';

import 'package:dart_wormhole_william/client/client.dart';
import 'package:dart_wormhole_william/client/file.dart';
import 'package:dart_wormhole_william/client/file.dart' as f;
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/views/shared/file_picker.dart';
import 'package:destiny/views/shared/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';
import '../../settings.dart';

enum SendScreenStates {
  CodeGenerating,
  FileSelecting,
  FileSent,
  SendError,
  FileSending,
  CodeGenerated,
  Initial,
}

class SendSharedState extends ChangeNotifier {
  static const MethodChannel shareFile =
      MethodChannel("destiny.androids/share_file");
  String? code;
  f.File? sendingFile;

  SendScreenStates currentState = SendScreenStates.Initial;

  final appSettings = getIt<AppSettings>();

  CancelFunc cancelFunc = () {
    print("No cancel function assigned. Doing nothing");
  };

  String? error;
  String? errorMessage;
  String? errorTitle;

  SendSharedState() {
    SendSharedState.shareFile.setMethodCallHandler((call) async {
      if (Platform.isAndroid) {
        await (call.arguments as String).androidUriToReadOnlyFile().then(send);
      } else {
        throw Exception(
            "Share file channel handling not implemented on ${Platform.operatingSystem}");
      }
    });
  }

  Future<int> get fileSize =>
      sendingFile?.metadata().then((metadata) => metadata.fileSize!) ??
      Future.error("No file size as there is no file being sent");

  Future<String> get fileName =>
      sendingFile?.metadata().then((metadata) => metadata.fileName!) ??
      Future.error("No file name as there is no file being sent");
  bool selectingFile = false;

  void setState(void Function() change) {
    change();
    notifyListeners();
  }

  void reset() {
    setState(() {
      code = null;
      sendingFile = null;
      currentState = SendScreenStates.Initial;
      error = null;
      errorMessage = null;
      errorTitle = null;
      selectingFile = false;

      cancelFunc = () {
        print("No transfer to cancel");
      };

      progress = ProgressSharedState(setState, () {
        currentState = SendScreenStates.FileSending;
      });
    });
  }

  late ProgressSharedState progress = ProgressSharedState(setState, () {
    currentState = SendScreenStates.FileSending;
  });

  Widget widgetFromMetadata(Widget Function(Metadata) f) {
    return FutureBuilder<Metadata>(
        future: sendingFile?.metadata() ?? Future.error("Not sending a file"),
        builder: (context, snapshot) {
          return snapshot.data != null
              ? f(snapshot.data!)
              : Text("No file metadata");
        });
  }

  void defaultErrorHandler(Object error) {
    this.setState(() {
      currentState = SendScreenStates.SendError;
      this.errorMessage = "$ERROR_SENDING_FILE: $error";
      this.error = '';
      this.errorTitle = ERROR_SENDING_FILE;

      if (error is ClientError) {
        switch (error.errorCode) {
          case ErrCodeTransferRejected:
            this.errorTitle = TRANSFER_CANCELLED;
            this.error = THE_RECEIVER_REJECTED_THIS_TRANSFER;
            break;
          case ErrCodeTransferCancelled:
            this.errorTitle = TRANSFER_CANCELLED;
            this.error = YOU_HAVE_CANCELLED_THE_TRANSFER;
            break;
          case ErrCodeTransferCancelledByReceiver:
            this.errorTitle = TRANSFER_CANCELLED_INTERRUPTED;
            this.error = EITHER_THE_TRANSFER_WAS_CANCELLED_BY;
            break;
          case ErrCodeWrongCode:
            this.errorTitle = OOPS;
            this.error = THE_RECEIVER_HAS_ENTERED_THE_WRONG_CODE;
            break;
          case ErrCodeSendTextError:
            this.errorTitle = SOMETHING_WENT_WRONG;
            // TODO: map error to user friendly name (case invalid nameplate)
            break;
          case ErrCodeSendFileError:
            this.errorTitle = SOMETHING_WENT_WRONG;
            // TODO: map error to user friendly name (case invalid nameplate)
            break;
          case ErrCodeConnectionRefused:
            this.errorTitle = OOPS;
            this.error = ERR_CONNECTION_REFUSED;
            break;
          case ErrCodeGenerationFailed:
            this.errorTitle = OOPS;
            this.error = ERR_CONNECTION_REFUSED;
            break;
          default:
            this.errorTitle = SOMETHING_WENT_WRONG;
            // TODO: map error to user friendly name (case invalid nameplate)
            break;
        }
      }
    });

    throw error;
  }

  Future<void> send(f.File file) async {
    if (currentState == SendScreenStates.CodeGenerating)
      return Future.error(GENERATING_MORE_THAN_ONE_CODE_AT_THE_SAME_TIME);
    setState(() {
      sendingFile = file;
      currentState = SendScreenStates.CodeGenerating;
    });

    final client = createClient();
    return await client.sendFile(file, progress.progressHandler).then(
        (result) async {
      setState(() {
        code = result.code;
        currentState = SendScreenStates.CodeGenerated;
        cancelFunc = result.cancel;
      });

      await result.done.then((result) {
        setState(() {
          currentState = SendScreenStates.FileSent;
        });
      }, onError: defaultErrorHandler);
    }, onError: defaultErrorHandler);
  }

  Client createClient() => Client(appSettings.config());

  Widget widgetByState(
      Widget Function() generateCodeUI,
      Widget Function() selectAFileUI,
      Widget Function() sendingError,
      Widget Function() sendingDone,
      Widget Function() sendingProgress) {
    switch (currentState) {
      case SendScreenStates.Initial:
      case SendScreenStates.FileSelecting:
        return selectAFileUI();

      case SendScreenStates.FileSent:
        return sendingDone();

      case SendScreenStates.SendError:
        return sendingError();
      case SendScreenStates.FileSending:
        return sendingProgress();
      case SendScreenStates.CodeGenerating:
      case SendScreenStates.CodeGenerated:
        return generateCodeUI();
    }
  }

  Future<void> handleSelectFile() async {
    if (!selectingFile) {
      this.setState(() {
        selectingFile = true;
      });
      await getFilePicker().showSelectFile().onError((error, stackTrace) {
        throw error!;
      }).then((file) async {
        await send(file);
      }).whenComplete(() {
        this.setState(() {
          selectingFile = false;
        });
      });
    }
  }

  void cancelSend() {
    cancelFunc();
    notifyListeners();
  }
}
