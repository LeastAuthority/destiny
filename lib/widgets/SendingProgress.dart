import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/widgets/DescriptionContainer.dart';

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
        DescriptionContainer(
            '2 Seconds',
            TextAlign.left,
            16.0.h,
            12.sp,
            Key('Timing_Progress')
        ),
        DescriptionContainer(
            'App must remain open until the transfer is complete.',
            TextAlign.center,
            16.0.h,
            18.sp,
            Key('APP_MUST_REMAIN_OPEN')
        ),
        Button('Cancel', () {})
      ],
    );
  }
}
