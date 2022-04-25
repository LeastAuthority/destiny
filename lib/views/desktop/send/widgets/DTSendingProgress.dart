import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTButton.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTFileInfo.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/CustomLinearProgressIndicator.dart';

class DTSendingProgress extends StatelessWidget {
  final String fileName;
  final double percentage;
  final String remainingTimeString;
  final int totalSize;
  final CancelFunc cancel;

  DTSendingProgress(this.totalSize, this.fileName, this.percentage,
      this.remainingTimeString, this.cancel);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 2.0, color: CustomColors.purple),
        ),
        width: 300.0.w,
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 80.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Heading(
                  title: SENDING_IN_PROGRESS,
                  textStyle: Theme.of(context).textTheme.headline1,
                  // key: Key('Timing_Progress'),
                ),
                SizedBox(
                  height: 40.0,
                ),
                DTFileInfo(totalSize, fileName),
                Container(
                  margin: EdgeInsets.only(top: 32.0),
                  width: 280.0,
                  height: 5.0,
                  child: CustomLinearProgressIndicator(
                    value: percentage,
                  ),
                ),
                Heading(
                  title: remainingTimeString,
                  marginTop: 16.0,
                  textStyle: Theme.of(context).textTheme.subtitle1,
                  key: Key('Timing_Progress'),
                ),
                Container(
                  width: 260.0,
                  child: Heading(
                    marginTop: 40.0,
                    title:
                        'App must remain open until the transfer is complete.',
                    textStyle: Theme.of(context).textTheme.headline5,
                    key: Key('APP_MUST_REMAIN_OPEN'),
                  ),
                ),
                SizedBox(
                  height: 40.0.h,
                ),
                DTButton('Cancel', () {
                  cancel();
                }),
                SizedBox(
                  height: 120.0,
                )
              ],
            ),
          ],
        ));
  }
}
