import 'dart:io';

import 'package:dart_wormhole_gui/views/shared/progress.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
  late PlatformFile sendingFile;

  SendScreenStates currentState = SendScreenStates.Initial;

  final Config config;
  late final Client client = Client(config);
  late CancelFunc cancelFunc;

  ClientError? error;
  String? errorMessage;
  StackTrace? stacktrace;

  SendShared(this.config);

  int get fileSize => sendingFile.size;

  String get fileName => sendingFile.name;
  bool selectingFile = false;

  late ProgressShared progress = ProgressShared(setState, () {
    currentState = SendScreenStates.FileSending;
  });

  Future<void> send(PlatformFile file) async {
    setState(() {
      sendingFile = file;
      currentState = SendScreenStates.CodeGenerating;
    });

    return await client
        .sendFile(File(file.path!), progress.progressHandler)
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
          this.currentState = SendScreenStates.SendError;
          this.error = error;
          this.errorMessage = "Error sending file: $error";
          this.stacktrace = stacktrace as StackTrace;
          print("Error sending file\n$error\n$stacktrace");

          if (error is ClientError) {
            switch (error.errorCode) {
              case ErrCodeTransferRejected:
                this.currentState = SendScreenStates.TransferRejected;
                break;
              case ErrCodeTransferCancelled:
                this.currentState = SendScreenStates.TransferCancelled;
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
        // TODO fix this
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

  void handleSelectFile() async {
    if (!selectingFile) {
      try {
        this.setState(() {
          selectingFile = true;
        });
        FilePickerResult? result =
            await FilePicker.platform.pickFiles(allowMultiple: false);
        if (result != null) {
          PlatformFile file = result.files.first;
          send(file);
        } else {
          // User canceled the picker
        }
      } finally {
        this.setState(() {
          selectingFile = false;
        });
      }
    }
  }

  void cancelSend() {
    setState(() {
      currentState = SendScreenStates.FileSelecting;
    });
  }

  Widget build(BuildContext context);
}

abstract class SendState extends StatefulWidget {
  final Config config;
  SendState(this.config, {Key? key}) : super(key: key);
}
