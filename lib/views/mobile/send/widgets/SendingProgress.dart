import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          textStyle: Theme.of(context).textTheme.bodyText2,
          key: Key('Timing_Progress'),
        ),
        Heading(
          title: 'App must remain open until the transfer is complete.',
          textAlign: TextAlign.center,
          marginTop:16.0.h,
          textStyle: Theme.of(context).textTheme.bodyText1,
          key: Key('APP_MUST_REMAIN_OPEN'),
        ),
        Button(title: 'Cancel', handleSelectFile: () {}, disabled: false)
      ],
    );
  }
}
