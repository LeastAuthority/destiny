import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/views/desktop//widgets/DTFileInfo.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/DTButton.dart';

class SendingDone extends StatelessWidget {
  final int fileSize;
  final String fileName;
  final Function handleDoneButtonPressed;
  SendingDone(this.fileSize, this.fileName, this.handleDoneButtonPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 2.0, color: CustomColors.purple),
        ),
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 80.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Heading(
              title: FILE_TRANSFER_SUCCESSFULLY,
              textAlign: TextAlign.center,
              textStyle: Theme.of(context).textTheme.headline1,
              // key: Key('Timing_Progress'),
            ),
            DTFileInfo(fileSize, fileName),
            Heading(
              title: FILE_SENT,
              textAlign: TextAlign.center,
              marginTop: 16.0,
              textStyle: Theme.of(context).textTheme.headline1,
              key: Key('Timing_Progress'),
            ),
            Image.asset(
              CHECK_ICON,
              width: 64.0,
            ),
            DTButton(DONE, () {
              handleDoneButtonPressed();
            }),
            SizedBox(
              height: 37.0.h,
            )
          ],
        ));
  }
}
