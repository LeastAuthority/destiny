import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/DTFileInfo.dart';

class DTReceivingDone extends StatelessWidget {
  final int fileSize;
  final String fileName;
  final String path;
  DTReceivingDone(this.fileSize, this.fileName, this.path);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            padding: EdgeInsets.only(right: 40.0.w),
            child: SizedBox(
              width: 500.0.w,
              child: Heading(
                title: FILE_DOWNLOADED_SUCCESSFULLY,
                textStyle: Theme.of(context).textTheme.headline1,
              ),
            )),
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
        SizedBox(
          height: 37.0.h,
        )
      ],
    );
  }
}
