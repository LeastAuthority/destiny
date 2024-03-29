import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/views/mobile/widgets/FileInfo.dart';
import 'package:destiny/views/mobile/widgets/buttons/Button.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:destiny/widgets/CustomLinearProgressIndicator.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendingProgress extends StatelessWidget {
  final int fileSize;
  final String fileName;
  final double percentage;
  final String remainingTimeString;
  final CancelFunc cancel;

  SendingProgress(this.fileSize, this.fileName, this.percentage,
      this.remainingTimeString, this.cancel);

  @override
  @protected
  @mustCallSuper
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: SENDING_IN_PROGRESS,
          textAlign: TextAlign.left,
          marginTop: 0.h,
          textStyle: Theme.of(context).textTheme.headline6,
          // key: Key('Timing_Progress'),
        ),
        FileInfo(fileSize, fileName),
        Padding(
            padding: EdgeInsets.fromLTRB(30.0.w, 0, 30.0.w, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 32.0.h),
                  height: 8.0.h,
                  child: CustomLinearProgressIndicator(
                    value: percentage,
                  ),
                ),
                Heading(
                  title: '$remainingTimeString',
                  textAlign: TextAlign.center,
                  marginTop: 16.0.h,
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  key: Key('Timing_Progress'),
                ),
                Heading(
                  title: APP_MUST_REMAIN_OPEN_UNTIL_THE_TRANSFER_IS_COMPLETE,
                  textAlign: TextAlign.center,
                  marginTop: 16.0.h,
                  textStyle: Theme.of(context).textTheme.headline6,
                  key: Key('APP_MUST_REMAIN_OPEN'),
                ),
              ],
            )),
        Button(
            title: CANCEL,
            handleClicked: () {
              cancel();
            },
            disabled: false),
        SizedBox(
          height: 38.0.h,
        )
      ],
    );
  }
}
