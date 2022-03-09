import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/CustomLinearProgressIndicator.dart';

class SendingProgress extends StatefulWidget {
  final int fileSize;
  final String fileName;
  final double percentage;
  final String remainingTimeString;

  SendingProgress(
      this.fileSize, this.fileName, this.percentage, this.remainingTimeString);
  @override
  State<SendingProgress> createState() => _SendingProgressState();
}

class _SendingProgressState extends State<SendingProgress> {
  @protected
  @mustCallSuper
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: CustomLinearProgressIndicator(
                    value: widget.percentage,
                  ),
                ),
                Heading(
                  title: '${widget.remainingTimeString}',
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
