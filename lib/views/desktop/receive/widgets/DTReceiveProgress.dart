import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/CustomLinearProgressIndicator.dart';
import '../../widgets/DTButton.dart';
import '../../widgets/DTFileInfo.dart';

class DTReceiveProgress extends StatefulWidget {
  final int fileSize;
  final String fileName;
  final double percentage;
  final String remainingTimeString;

  DTReceiveProgress(
      this.fileSize, this.fileName, this.percentage, this.remainingTimeString);

  @override
  State<DTReceiveProgress> createState() => _ReceiveProgressState();
}

class _ReceiveProgressState extends State<DTReceiveProgress> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: RECEIVING,
          textAlign: TextAlign.center,
          textStyle: Theme.of(context).textTheme.headline1,
          // key: Key('Timing_Progress'),
        ),
        Column(
          children: [
            DTFileInfo(widget.fileSize, widget.fileName),
            Container(
              width: 284.0.w,
              margin: EdgeInsets.only(top: 32.0.h),
              child: CustomLinearProgressIndicator(
                value: widget.percentage,
              ),
            ),
            Heading(
              title: '${widget.remainingTimeString}',
              textAlign: TextAlign.center,
              marginTop: 16.0.h,
              textStyle: Theme.of(context).textTheme.subtitle2,
              key: Key('Timing_Progress'),
            ),
            SizedBox(
              width: 500.0.w,
              child: Heading(
                title: THE_APP_MUST_REMAIN_OPEN_UNTIL_THE_TRANSFER_IS_COMPLETED,
                marginTop: 16.0.h,
                textStyle: Theme.of(context).textTheme.bodyText1,
                key: Key(APP_MUST_REMAIN_OPEN),
              ),
            )
          ],
        ),
        DTButton(CANCEL, () {}),
        SizedBox(
          height: 37.0.h,
        )
      ],
    );
  }
}
