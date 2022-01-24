import 'dart:ffi';
import 'dart:html';
import 'dart:io';

import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_william/client/c_structs.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ReceiveScreenStates {
  FileReceived,
  ReceiveError,
  FileReceiving,
  ReceiveConfirmation,
  Initial,
}

abstract class ReceiveShared<T extends ReceiveState> extends State<T> {
  String? _code;
  int totalReceived = 0;
  int totalSize = 0;
  int fileSize = 0;
  String fileName = '';
  dynamic currentTime;
  ReceiveScreenStates currentState = ReceiveScreenStates.Initial;
  SharedPreferences? prefs;
  Client client = Client();
  ReceiveShared();
  String path = '';

  void initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      path = prefs?.getString(PATH) ?? '';
    });
  }

  void progressHandler(dynamic progress) {
    if (progress is int) {
      var progressC = Pointer<Progress>.fromAddress(progress);
      setState(() {
        totalReceived = progressC.ref.transferredBytes;
        totalSize = progressC.ref.totalBytes;
        currentState = ReceiveScreenStates.FileReceiving;
        currentTime = DateTime.now();
      });
    } else {
      print('$WRONG_TYPE_FOR_PROGRESS ${progress.runtimeType}');
    }
  }

  void codeChanged(String code) {
    setState(() {
      _code = code;
    });
  }

  Future gePath() async {
    return prefs?.getString(PATH);
  }

  Future<String> getPathWithFileName(String path, String filename) async {
    String filePathWithName = '$path/$filename';
    return filePathWithName;
  }

  Future<PermissionStatus> canWriteToFile() async {
    if (Platform.isAndroid) {
      return await Permission.storage.request();
    } else if (Platform.isLinux) {
      return PermissionStatus.granted;
    } else {
      print("Implement write checks for ${Platform()}");
      return PermissionStatus.permanentlyDenied;
    }
  }

  void receive() async {
    String? _path = await gePath();
    if (_path == null) {
      this.setState(() {
        path = DOWNLOADS_FOLDER_PATH;
      });
      _path = DOWNLOADS_FOLDER_PATH;
      prefs?.setString(PATH, _path);
    } else {
      _path = path;
    }
    client.recvFile(_code!, progressHandler).then((result) async {
      String filePathWithName =
          await getPathWithFileName(_path!, result.fileName);
      File file = File(filePathWithName);
      file.writeAsBytes(result.data);
      this.setState(() {
        currentState = ReceiveScreenStates.FileReceived;
        fileName = result.fileName;
        fileSize = result.data.length;
      });
    });
  }

  Widget widgetByState(
      Widget Function() receivingDone,
      Widget Function() receiveProgress,
      Widget Function() enterCodeUI,
      Widget Function() receiveConfirmation) {
    switch (currentState) {
      case ReceiveScreenStates.Initial:
        return enterCodeUI();
      case ReceiveScreenStates.ReceiveError:
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
  ReceiveState({Key? key}) : super(key: key);
}
