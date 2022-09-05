import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/constants/asset_path.dart';
import 'package:destiny/views/mobile/widgets/FileInfo.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:destiny/widgets/buttons/Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendingDone extends StatelessWidget {
  final int fileSize;
  final String fileName;
  final Function handleDoneButtonPressed;
  SendingDone(this.fileSize, this.fileName, this.handleDoneButtonPressed);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: FILE_TRANSFER_SUCCESSFULLY,
          textAlign: TextAlign.left,
          marginTop: 0.h,
          textStyle: Theme.of(context).textTheme.headline6,
          // key: Key('Timing_Progress'),
        ),
        FileInfo(fileSize, fileName),
        Heading(
          title: FILE_SENT,
          textAlign: TextAlign.center,
          marginTop: 16.0.h,
          textStyle: Theme.of(context).textTheme.headline1,
          key: Key('Timing_Progress'),
        ),
        Image.asset(
          CHECK_ICON,
          width: 64.0.w,
        ),
        Button(DONE, handleDoneButtonPressed, false),
        SizedBox(
          height: 37.0.h,
        )
      ],
    );
  }
}
