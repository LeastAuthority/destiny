import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendingProgress extends StatefulWidget {
  final int fileSize;
  final String fileName;
  final int totalSent;
  final int totalSize;
  final DateTime currentTime;
  SendingProgress(this.fileSize, this.fileName, this.totalSent, this.totalSize,
      this.currentTime);
  @override
  State<SendingProgress> createState() => _SendingProgressState();
}

class _SendingProgressState extends State<SendingProgress> {
  late final DateTime startingTime;
  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    startingTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = widget.currentTime.difference(startingTime);
    double bytesPerSecond = widget.totalSent / duration.inSeconds;
    int remainingTime =
        ((widget.totalSize - widget.totalSent) / bytesPerSecond).ceil();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: SENDING_IN_PROGRESS,
          textAlign: TextAlign.left,
          marginTop: 0.h,
          textStyle: Theme.of(context).textTheme.bodyText1,
          // key: Key('Timing_Progress'),
        ),
        FileInfo(widget.fileSize, widget.fileName),
        Padding(
            padding: EdgeInsets.fromLTRB(30.0.w, 0, 30.0.w, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 32.0.h),
                  child: LinearProgressIndicator(
                    backgroundColor: Theme.of(context)
                        .progressIndicatorTheme
                        .linearTrackColor,
                    color: Theme.of(context).progressIndicatorTheme.color,
                    value: widget.totalSent / widget.totalSize,
                  ),
                ),
                Heading(
                  title: '$remainingTime $SECONDS',
                  textAlign: TextAlign.center,
                  marginTop: 16.0.h,
                  textStyle: Theme.of(context).textTheme.bodyText2,
                  key: Key('Timing_Progress'),
                ),
                Heading(
                  title: APP_MUST_REMAIN_OPEN_UNTIL_THE_TRANSFER_IS_COMPLETE,
                  textAlign: TextAlign.center,
                  marginTop: 16.0.h,
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  key: Key('APP_MUST_REMAIN_OPEN'),
                ),
              ],
            )),
        Button(title: CANCEL, handleClicked: () {}, disabled: false),
        SizedBox(
          height: 38.0.h,
        )
      ],
    );
  }
}
