import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceivingDone extends StatelessWidget {
  final int fileSize;
  final String fileName;
  final String path;
  ReceivingDone(this.fileSize, this.fileName, this.path);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: FILE_DOWNLOADED_SUCCESSFULLY,
          textAlign: TextAlign.left,
          marginTop: 0.h,
          textStyle: Theme.of(context).textTheme.bodyText1,
          // key: Key('Timing_Progress'),
        ),
        FileInfo(fileSize, fileName),
        Heading(
          title: FILE_RECEIVED,
          textAlign: TextAlign.center,
          marginTop: 16.0.h,
          textStyle: TextStyle(
              fontSize: 25.sp, fontFamily: LATO, fontWeight: FontWeight.bold),
          key: Key('Timing_Progress'),
        ),
        Image.asset(
          CHECK_ICON,
          width: 64.0.w,
        ),
        Heading(
          title: DOWNLOADED_TO + '\n',
          textAlign: TextAlign.center,
          marginTop: 0,
          path: path,
          textStyle: Theme.of(context).textTheme.bodyText1,
          key: Key(SETTINGS_SCREEN_HEADING),
        ),
        SizedBox(
          height: 37.0.h,
        )
      ],
    );
  }
}
