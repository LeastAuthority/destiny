import 'dart:async';

import 'package:dart_wormhole_gui/views/shared/progress.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:dart_wormhole_william/client/file.dart';
import 'package:dart_wormhole_william/client/file.dart' as f;
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';

import '../../config/routes/routes.dart';
import '../../constants/app_constants.dart';
import 'file_picker.dart';

enum SendScreenStates {
  TransferCancelled,
  TransferRejected,
  CodeGenerating,
  FileSelecting,
  FileSent,
  SendError,
  FileSending,
  CodeGenerated,
  Initial,
}

abstract class SendShared<T extends SendState> extends State<T> {
  String? code;
  late f.File sendingFile;

  SendScreenStates currentState = SendScreenStates.Initial;

  final Config config;
  late final Client client = Client(config);
  CancelFunc cancelFunc = () {
    print("No cancel function assigned. Doing nothing");
  };

  ClientError? error;
  String? errorMessage;
  String? errorTitle;
  SendShared(this.config);

  Future<int> get fileSize =>
      sendingFile.metadata().then((metadata) => metadata.fileSize!);

  Future<String> get fileName =>
      sendingFile.metadata().then((metadata) => metadata.fileName!);
  bool selectingFile = false;

  late ProgressShared progress = ProgressShared(setState, () {
    currentState = SendScreenStates.FileSending;
  });

  Widget widgetFromMetadata(Widget Function(Metadata) f) {
    return FutureBuilder<Metadata>(
        future: sendingFile.metadata(),
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
          this.errorMessage = "Error sending file: $error";
          this.errorTitle = "Error Sending File";
          error = error;

          print("Error sending file\n$error\n$stacktrace");

          if (error is ClientError) {
            switch (error.errorCode) {
              case ErrCodeTransferRejected:
                currentState = SendScreenStates.TransferRejected;
                break;
              case ErrCodeTransferCancelled:
                currentState = SendScreenStates.TransferCancelled;
                break;
              case ErrCodeWrongCode:
                errorMessage = ERR_WRONG_CODE_SENDER;
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
      Widget Function() transferCancelled,
      Widget Function() transferRejected) {
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
      case SendScreenStates.TransferCancelled:
        return transferCancelled();
      case SendScreenStates.TransferRejected:
        return transferRejected();
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
    Navigator.pushReplacementNamed(
      context,
      SEND_ROUTE,
    );
  }

  Widget build(BuildContext context);
}

abstract class SendState extends StatefulWidget {
  final Config config;
  SendState(this.config, {Key? key}) : super(key: key);
}
