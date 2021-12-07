import 'dart:io';

import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widget/DTSendingProgress.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Send extends StatefulWidget {
  Send({Key? key}) : super(key: key);
  @override
  _SendDefaultState createState() => _SendDefaultState();
}

class _SendDefaultState extends State<Send> {
  String _msg = 'test test';
  String? _code = null;
  String fileName = '';
  int fileSize = 0;
  TextEditingController _codeTxtCtrl = TextEditingController();

  Client client = Client();

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
        appBar:
            CustomAppBar(key: Key(CUSTOM_NAV_BAR), path: DESKTOP_SEND_ROUTE),
        body: WillPopScope(
            onWillPop: () async => false,
            child: Container(
                width: double.infinity,
                key: Key(SEND_SCREEN_BODY),
                padding: EdgeInsets.only(left: 125.0.w, right: 125.0.w),
                child: Container(
                    height: double.infinity,
                    margin: EdgeInsets.fromLTRB(16.0.w, 30.0.h, 16.0.w, 22.0.h),
                    child: DottedBorder(
                        dashPattern: [8, 4],
                        strokeWidth: 2.0.h,
                        color: CustomColors.purple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [DTSendingProgress(0, 'aaaa')],
                        )
                        // child: fileName.length > 0 ?
                        //  Container (
                        //   height:  double.infinity,
                        //   margin: EdgeInsets.fromLTRB(16.0.w, 30.0.h, 16.0.w, 22.0.h),
                        //   child: DTCodeGeneration(
                        //       fileName:  'ddddd.mp3',
                        //       fileSize: 22,
                        //       code: _code,
                        //       isCodeGenerating: false,
                        //     )
                        // ) :
                        // DTSelectAFile(
                        //     handleSelectFile: handleSelectFile,
                        //     handleFileDroped: (path) {
                        //         setState(() {
                        //           fileName = 'path';
                        //         });
                        //    }
                        // )
                        )))));
  }
}
