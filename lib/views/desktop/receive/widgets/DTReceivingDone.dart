import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/constants/asset_path.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/DTButton.dart';
import '../../widgets/DTFileInfo.dart';

class DTReceivingDone extends StatelessWidget {
  final int fileSize;
  final String fileName;
  final String path;
  final Function handleDoneButtonPressed;
  DTReceivingDone(
      this.fileSize, this.fileName, this.path, this.handleDoneButtonPressed);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Heading(
          title: FILE_DOWNLOAD_SUCCESSFUL,
          textStyle: Theme.of(context).textTheme.headline1,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DTFileInfo(fileSize, fileName),
            Image.asset(
              CHECK_ICON,
              width: 106.0.w,
            ),
            Heading(
              title: DOWNLOADED_TO + '\n',
              path: path,
              textStyle: Theme.of(context).textTheme.bodyText1,
              key: Key(SETTINGS_SCREEN_HEADING),
            ),
            DTButton(DONE, () {
              handleDoneButtonPressed();
            }),
            SizedBox(
              height: 37.0.h,
            )
          ],
        ))
      ],
    );
  }
}
