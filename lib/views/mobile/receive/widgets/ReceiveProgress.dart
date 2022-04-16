import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/CustomLinearProgressIndicator.dart';

class ReceiveProgress extends StatelessWidget {
  final int fileSize;
  final String fileName;
  final double percentage;
  final String remainingTimeString;
  final CancelFunc cancel;

  ReceiveProgress(this.fileSize, this.fileName, this.percentage,
      this.remainingTimeString, this.cancel);

  late final DateTime startingTime;
  int previousSent = 0;
  int sentPerSecond = 1;

  @protected
  @mustCallSuper
  void initState() {
    // super.initState();
    startingTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: RECEIVING,
          textAlign: TextAlign.left,
          textStyle: Theme.of(context).textTheme.headline6,
          // key: Key('Timing_Progress'),
        ),
        Column(
          children: [
            FileInfo(fileSize, fileName),
            Container(
              width: 284.0.w,
              margin: EdgeInsets.only(top: 32.0.h),
              height: 8.0.h,
              child: CustomLinearProgressIndicator(
                value: percentage,
              ),
            ),
            Heading(
              title: '${remainingTimeString}',
              marginTop: 16.0.h,
              textStyle: Theme.of(context).textTheme.bodyText1,
              key: Key(TIMING_PROGRESS),
            ),
            Heading(
              title: PLEASE_KEEP_THE_APP_OPEN_UNTIL_FILE_IS_DOWNLOADED,
              marginTop: 16.0.h,
              textStyle: Theme.of(context).textTheme.headline6,
              key: Key(APP_MUST_REMAIN_OPEN),
            ),
          ],
        ),
        Button(
            title: CANCEL,
            handleClicked: () {
              cancel();
            },
            disabled: false),
        SizedBox(
          height: 37.0.h,
        )
      ],
    );
  }
}
