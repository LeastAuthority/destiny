import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/buttons/Button.dart';

class ReceivingDone extends StatelessWidget {
  final int fileSize;
  final String fileName;
  final String path;
  final Function handleDoneButtonPressed;
  ReceivingDone(
      this.fileSize, this.fileName, this.path, this.handleDoneButtonPressed);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: FILE_DOWNLOADED_SUCCESSFULLY + '\n',
          path: path,
          textAlign: TextAlign.left,
          textStyle: Theme.of(context).textTheme.headline6,
          // key: Key('Timing_Progress'),
        ),
        FileInfo(fileSize, fileName),
        Heading(
          title: FILE_RECEIVED,
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
