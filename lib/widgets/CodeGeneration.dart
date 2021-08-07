import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/widgets/RowGroupButtons.dart';
import '../widgets/Button.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';

class CodeGeneration extends StatelessWidget {
  String? fileName = '';
  int? fileSize = 0;

  CodeGeneration({Key? key, String? fileName, int? fileSize}):super(key:key) {
    this.fileName = fileName;
    this.fileSize = fileSize;
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        FileInfo(fileSize, fileName),
        RowGroupButton('Generating Code'),
        Heading(
            title: SHARE_CODE_WITH_RECIPIENT_AND_WAIT_UNTIL_THE_TRANSFER_IS_COMPLETE,
            textAlign:TextAlign.center,
            marginTop: 16.0.h,
            fontSize: 12.sp,
            key:Key('Generation_Description')
        ),
        Button('Cancel', () {
        })
      ],
    );
  }
}
