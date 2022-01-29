import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/views/shared/util.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiveProgress extends StatefulWidget {
  final int fileSize;
  final String fileName;
  final int totalReceived;
  final int totalSize;
  final DateTime currentTime;
  ReceiveProgress(this.fileSize, this.fileName, this.totalReceived,
      this.totalSize, this.currentTime);

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

  String getRemainingTime() {
    Duration duration = widget.currentTime.difference(startingTime);
    if ((widget.totalReceived - previousSent) > 0 && duration.inSeconds >= 1)
      this.setState(() {
        sentPerSecond = widget.totalReceived - previousSent;
        previousSent = widget.totalReceived;
      });
    int remainingTimeInSeconds =
        ((widget.totalSize - widget.totalReceived) ~/ sentPerSecond);
    return remainingTimeInSeconds.timeRemainingInProperUnit;
  }

  @override
  Widget build(BuildContext context) {
    String remainingTime = getRemainingTime();
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
            FileInfo(widget.totalSize, widget.fileName),
            Container(
              width: 284.0.w,
              margin: EdgeInsets.only(top: 32.0.h),
              child: LinearProgressIndicator(
                backgroundColor:
                    Theme.of(context).progressIndicatorTheme.linearTrackColor,
                color: Theme.of(context).progressIndicatorTheme.color,
                value: widget.totalReceived / widget.totalSize,
              ),
            ),
            Heading(
              title: '$remainingTime',
              textAlign: TextAlign.center,
              marginTop: 16.0.h,
              textStyle: Theme.of(context).textTheme.bodyText2,
              key: Key(TIMING_PROGRESS),
            ),
            Heading(
              title: PLEASE_KEEP_THE_APP_OPEN_UNTIL_FILE_IS_DOWNLOADED,
              textAlign: TextAlign.center,
              marginTop: 16.0.h,
              textStyle: Theme.of(context).textTheme.bodyText1,
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
