import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiveProgress extends StatelessWidget {
  final int fileSize;
  final String fileName;
  ReceiveProgress(this.fileSize, this.fileName);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: RECEIVING,
          textAlign: TextAlign.left,
          marginTop: 0.0.h,
          textStyle: Theme.of(context).textTheme.bodyText1,
          // key: Key('Timing_Progress'),
        ),
        Column(
          children: [
            FileInfo(fileSize, fileName),
            Container(
              width: 284.0.w,
              margin: EdgeInsets.only(top: 32.0.h),
              child: LinearProgressIndicator(
                value: 0.5,
              ),
            ),
            Heading(
              title: '2 Seconds',
              textAlign: TextAlign.center,
              marginTop: 16.0.h,
              textStyle: Theme.of(context).textTheme.bodyText2,
              key: Key('Timing_Progress'),
            ),
            Heading(
              title: PLEASE_KEEP_THE_APP_OPEN_UNTIL_FILE_IS_DOWNLOADED,
              textAlign: TextAlign.center,
              marginTop: 16.0.h,
              textStyle: Theme.of(context).textTheme.bodyText1,
              key: Key('APP_MUST_REMAIN_OPEN'),
            ),
          ],
        ),
        Button(title: 'Cancel', handleClicked: () {}, disabled: false),
        SizedBox(
          height: 37.0.h,
        )
      ],
    );
  }
}
