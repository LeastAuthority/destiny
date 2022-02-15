import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiveConfirmation extends StatelessWidget {
  final String fileName;
  final int fileSize;
  final Function acceptDownload;
  final Function rejectDownload;

  ReceiveConfirmation(
      this.fileName, this.fileSize, this.acceptDownload, this.rejectDownload);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: FILE_READY_TO_DOWNLOAD,
          textAlign: TextAlign.left,
          marginTop: 0.0.h,
          textStyle: Theme.of(context).textTheme.bodyText1,
          // key: Key('Timing_Progress'),
        ),
        FileInfo(fileSize, fileName),
        Heading(
          title: PLEASE_KEEP_THE_APP_OPEN_UNTIL_FILE_IS_DOWNLOADED,
          textAlign: TextAlign.center,
          marginTop: 16.0.h,
          textStyle: Theme.of(context).textTheme.bodyText1,
          key: Key(APP_MUST_REMAIN_OPEN),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(
                title: DOWNLOAD,
                handleClicked: acceptDownload,
                disabled: false),
            Button(
                title: CANCEL, handleClicked: rejectDownload, disabled: false),
          ],
        ),
        SizedBox(
          height: 8.0.h,
        )
      ],
    );
  }
}
