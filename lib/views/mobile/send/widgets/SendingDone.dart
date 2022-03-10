import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendingDone extends StatelessWidget {
  final int fileSize;
  final String fileName;
  SendingDone(this.fileSize, this.fileName);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: FILE_SENT_SUCCESSFULLY,
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
        SizedBox(
          height: 150.0.h,
        )
      ],
    );
  }
}
