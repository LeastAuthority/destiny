import 'dart:io';

import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/CodeGeneration.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SelectAFileUI.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendDefault extends StatefulWidget {
  SendDefault({Key? key}) : super(key: key);
  @override
  _SendDefaultState createState() => _SendDefaultState();
}

class _SendDefaultState extends State<SendDefault> {
  String _msg = 'test test';
  String? _code = null;
  String fileName = '';
  bool isCodeGenerating = true;
  int fileSize = 0;
  TextEditingController _codeTxtCtrl = TextEditingController();

  Client client = Client();

  _SendDefaultState() {}

  void _msgChanged(String msg) {
    setState(() {
      _msg = msg;
    });
  }

  void _codeChanged(String? code) {
    setState(() {
      _code = code;
    });
  }

  void _send(PlatformFile file) {
    // TODO cleanup these prints
    print("Sending a file ${file.name}");
    client.sendFile(File(file.path.toString())).then((result) {
      print("Got code ${result.code}");
      _codeChanged(result.code);
      result.done.then((value) {
        _msgChanged("File transfer successful");
        _codeChanged(null);
      });
    });
  }

  void handleSelectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      PlatformFile file = result.files.first;
      _send(file);
      setState(() {
        fileName = file.name;
        fileSize = file.size ~/ 8;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomBar(
          path: SEND_ROUTE,
          key: Key(BOTTOM_NAV_BAR),
        ),
        appBar: CustomAppBar(
          title: SEND,
          key: Key(CUSTOM_NAV_BAR),
        ),
        body: WillPopScope(
            onWillPop: () async => false,
            child: Container(
                width: double.infinity,
                key: Key(SEND_SCREEN_BODY),
                padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
                child: fileSize > 0
                    ? CodeGeneration(
                        isCodeGenerating: isCodeGenerating,
                        fileName: fileName,
                        fileSize: fileSize,
                        code: _code ?? '',
                        key: Key(SEND_SCREEN_CODE_GENERATION_UI),
                      )
                    : SelectAFileUI(
                        fileSize, fileName, _code ?? '', handleSelectFile))));
  }
}
