import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';

import 'Button.dart';
import 'FileInfo.dart';

class SendingProgress extends StatelessWidget {
  final int fileSize;
  final String fileName;

  SendingProgress(this.fileSize, this.fileName);

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        FileInfo(fileSize, fileName),
        Container(
          margin: EdgeInsets.only(top: 32.0.h),
          child: LinearProgressIndicator(
            value: 0.5,
          ),
        ),
        Heading(
          title: '2 Seconds',
          textAlign: TextAlign.left,
          marginTop:16.0.h,
          fontSize:12.sp,
          fontFamily: MONTSERRAT,
          fontWeight: FontWeight.w300,
          key: Key('Timing_Progress'),
        ),
        Heading(
          title: 'App must remain open until the transfer is complete.',
          textAlign: TextAlign.center,
          marginTop:16.0.h,
          fontSize:18.sp,
          fontFamily: MONTSERRAT,
          fontWeight: FontWeight.w300,
          key: Key('APP_MUST_REMAIN_OPEN'),
        ),
        Button('Cancel', () {})
      ],
    );
  }
}
