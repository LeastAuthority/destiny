import 'dart:ffi';
import 'dart:io';

import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_william/client/c_structs.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ReceiveScreenStates {
  FileReceived,
  ReceiveError,
  FileReceiving,
  Initial,
}

abstract class ReceiveShared<T extends ReceiveState> extends State<T> {
  String? _code;
  int totalReceived = 0;
  int totalSize = 0;
  int fileSize = 0;
  String fileName = '';
  ReceiveScreenStates currentState = ReceiveScreenStates.Initial;
  SharedPreferences? prefs;

  Client client = Client();

  ReceiveShared();

  void progressHandler(dynamic progress) {
    if (progress is int) {
      var progressC = Pointer<Progress>.fromAddress(progress);
      setState(() {
        totalReceived = progressC.ref.transferredBytes;
        totalSize = progressC.ref.totalBytes;
        currentState = ReceiveScreenStates.FileReceiving;
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
    prefs = await SharedPreferences.getInstance();
    return prefs?.getString(PATH);
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
    String? path = await gePath();
    await canWriteToFile().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        if (path != null) {
          client.recvFile(_code!, progressHandler).then((result) async {
            File file = File("$path/${result.fileName}");
            await file.create(recursive: true).then((file) {
              return file.writeAsBytes(result.data.toList());
            });
            this.setState(() {
              currentState = ReceiveScreenStates.FileReceived;
              fileName = result.fileName;
              fileSize = result.data.length;
            });
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(MUST_CHOOSE_PATH_TO_SAVE_THE_FILE),
          ));
        }
      } else {
        // TODO implement permission denied UI
        print("Permission denied");
      }
    });
  }

  Widget widgetByState(Widget Function() receivingDone,
      Widget Function() receiveProgress, Widget Function() enterCodeUI) {
    switch (currentState) {
      case ReceiveScreenStates.Initial:
        return enterCodeUI();
      case ReceiveScreenStates.ReceiveError:
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
