import 'dart:io';
import 'dart:typed_data';

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

extension KBSize on Uint8List {
  int sizeInKb() {
    return (this.length / 1000).round();
  }
}

abstract class SendShared<T extends SendState> extends State<T> {
  String? code = null;
  PlatformFile? sendingFile;
  SendScreenStates currentState = SendScreenStates.Initial;

  int get fileSize => sendingFile?.bytes?.sizeInKb() ?? 0;

  String get fileName => sendingFile?.name ?? "";

  Client client = Client();

  SendShared();

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

  Widget build(BuildContext context);
}

abstract class SendState extends StatefulWidget {
  SendState({Key? key}) : super(key: key);
}
