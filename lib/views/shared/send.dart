import 'dart:async';

import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/shared/file_picker.dart';
import 'package:dart_wormhole_gui/views/shared/progress.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:dart_wormhole_william/client/file.dart';
import 'package:dart_wormhole_william/client/file.dart' as f;
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';

enum SendScreenStates {
  TransferCancelledOrRejected,
  CodeGenerating,
  FileSelecting,
  FileSent,
  SendError,
  FileSending,
  CodeGenerated,
  Initial,
}

class SendSharedState extends ChangeNotifier {
  String? code;
  f.File? sendingFile;

  SendScreenStates currentState = SendScreenStates.Initial;

  final Config config;
  late final Client client = Client(config);
  CancelFunc cancelFunc = () {
    print("No cancel function assigned. Doing nothing");
  };

  String? error;
  String? errorMessage;
  String? errorTitle;
  SendSharedState(this.config);

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

  Future<void> send(f.File file) async {
    setState(() {
      sendingFile = file;
      currentState = SendScreenStates.CodeGenerating;
    });

    return await client
        .sendFile(file, progress.progressHandler)
        .then((result) async {
      setState(() {
        code = result.code;
        currentState = SendScreenStates.CodeGenerated;
        cancelFunc = result.cancel;
      });

      await result.done.then((result) {
        setState(() {
          currentState = SendScreenStates.FileSent;
        });
      }, onError: (error, stacktrace) {
        this.setState(() {
          currentState = SendScreenStates.SendError;
          this.errorMessage = "$ERROR_SENDING_FILE: $error";
          this.errorTitle = ERROR_SENDING_FILE;

          print("$ERROR_SENDING_FILE\n$error\n$stacktrace");

          if (error is ClientError) {
            switch (error.errorCode) {
              case ErrCodeTransferRejected:
                currentState = SendScreenStates.TransferCancelledOrRejected;
                this.errorTitle = TRANSFER_CANCELLED;
                this.error = THE_RECEIVER_REJECTED_THIS_TRANSFER;
                break;
              case ErrCodeTransferCancelled:
                currentState = SendScreenStates.TransferCancelledOrRejected;
                this.errorTitle = TRANSFER_CANCELLED;
                this.error = YOU_HAVE_CANCELLED_THE_TRANSFER;
                break;
              case ErrCodeTransferCancelledByReceiver:
                currentState = SendScreenStates.TransferCancelledOrRejected;
                this.errorTitle = TRANSFER_CANCELLED_INTERRUPTED;
                this.error = EITHER_THE_TRANSFER_WAS_CANCELLED_BY;
                break;
              case ErrCodeWrongCode:
                this.errorTitle = OOPS;
                this.error = THE_RECEIVER_HAS_ENTERED_THE_WRONG_CODE;
                break;
              case ErrCodeSendTextError:
                this.errorTitle = SOMETHING_WENT_WRONG;
                errorMessage = this.error;
                this.error = "";
                break;
              case ErrCodeSendFileError:
                this.errorTitle = SOMETHING_WENT_WRONG;
                errorMessage = this.error;
                this.error = "";
                break;
              default:
                this.errorTitle = SOMETHING_WENT_WRONG;
                // to display error message in See Details
                errorMessage = this.error;
                this.error = "";
                break;
            }
          }
        });

        throw error;
      });
    });
  }

  Widget widgetByState(
      Widget Function() generateCodeUI,
      Widget Function() selectAFileUI,
      Widget Function() sendingError,
      Widget Function() sendingDone,
      Widget Function() sendingProgress,
      Widget Function() transferCancelledOrRejected) {
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
      case SendScreenStates.TransferCancelledOrRejected:
        return transferCancelledOrRejected();
    }
  }

  Future<void> handleSelectFile() async {
    if (!selectingFile) {
      this.setState(() {
        selectingFile = true;
      });
      await getFilePicker().showSelectFile().onError((error, stackTrace) {
        print(error);
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
    currentState = SendScreenStates.TransferCancelledOrRejected;
    cancelFunc();
    notifyListeners();
  }
}
