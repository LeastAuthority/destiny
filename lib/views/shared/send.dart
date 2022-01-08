import 'dart:ffi';
import 'dart:io';

import 'package:dart_wormhole_william/client/c_structs.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

enum SendScreenStates {
  CodeGenerating,
  FileSelecting,
  FileSent,
  SendError,
  FileSending,
  CodeGenerated,
  Initial,
}

abstract class SendShared<T extends SendState> extends State<T> {
  String? code = null;
  PlatformFile? sendingFile;
  int totalSent = 0;
  int totalSize = 0;
  SendScreenStates currentState = SendScreenStates.Initial;

  int get fileSize => sendingFile?.size ?? 0;

  String get fileName => sendingFile?.name ?? "";

  Client client = Client();

  SendShared();

  void progressHandler(dynamic progress) {
    if (progress is int) {
      var progressC = Pointer<Progress>.fromAddress(progress);
      setState(() {
        totalSent = progressC.ref.transferredBytes;
        totalSize = progressC.ref.totalBytes;
        currentState = SendScreenStates.FileSending;
      });
    } else {
      print(
          "Wrong type for progress. Expected int got ${progress.runtimeType}");
    }
  }

  void send(PlatformFile file) {
    setState(() {
      sendingFile = file;
      currentState = SendScreenStates.CodeGenerating;
      client
          .sendFile(File(file.path.toString()), progressHandler)
          .then((result) {
        setState(() {
          code = result.code;
          currentState = SendScreenStates.CodeGenerated;
        });

        result.done.then((result) {
          setState(() {
            currentState = SendScreenStates.FileSent;
          });
        });
      });
    });
  }

  Widget widgetByState(
      Widget Function() generateCodeUI,
      Widget Function() selectAFileUI,
      Widget Function() sendingDone,
      Widget Function() sendingProgress) {
    switch (currentState) {
      case SendScreenStates.Initial:
      case SendScreenStates.FileSelecting:
        return selectAFileUI();

      case SendScreenStates.FileSent:
        return sendingDone();

      case SendScreenStates.SendError:
      // TODO handle error states
      case SendScreenStates.FileSending:
        // TODO fix this
        return sendingProgress();
      case SendScreenStates.CodeGenerating:
      case SendScreenStates.CodeGenerated:
        return generateCodeUI();
    }
  }

  void handleSelectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      PlatformFile file = result.files.first;
      send(file);
      setState(() {
        sendingFile = file;
      });
    } else {
      // User canceled the picker
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
  SendState({Key? key}) : super(key: key);
}
