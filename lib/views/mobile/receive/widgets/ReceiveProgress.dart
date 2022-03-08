import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/CustomLinearProgressIndicator.dart';

class ReceiveProgress extends StatefulWidget {
  final int fileSize;
  final String fileName;
  final double percentage;
  final String remainingTimeString;

  ReceiveProgress(
      this.fileSize, this.fileName, this.percentage, this.remainingTimeString);

  @override
  State<ReceiveProgress> createState() => _ReceiveProgressState();
}

class _ReceiveProgressState extends State<ReceiveProgress> {
  late final DateTime startingTime;
  int previousSent = 0;
  int sentPerSecond = 1;

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
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
            FileInfo(widget.fileSize, widget.fileName),
            Container(
              width: 284.0.w,
              margin: EdgeInsets.only(top: 32.0.h),
              child: CustomLinearProgressIndicator(
                value: widget.percentage,
              ),
            ),
            Heading(
              title: '${widget.remainingTimeString}',
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
        Button(title: CANCEL, handleClicked: () {}, disabled: false),
        SizedBox(
          height: 37.0.h,
        )
      ],
    );
  }
}
