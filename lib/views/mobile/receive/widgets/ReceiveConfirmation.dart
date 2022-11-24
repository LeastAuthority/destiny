import 'dart:io' as dartIO;
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/views/mobile/widgets/FileInfo.dart';
import 'package:destiny/views/mobile/widgets/buttons/Button.dart';
import 'package:destiny/views/mobile/widgets/buttons/ButtonWithBackground.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiveConfirmation extends StatelessWidget {
  final String fileName;
  final int fileSize;
  final Function acceptDownload;
  final Function rejectDownload;
  final Function selectSaveDestination;

  ReceiveConfirmation(this.fileName, this.fileSize, this.acceptDownload,
      this.rejectDownload, this.selectSaveDestination);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: READY_TO_DOWNLOAD,
          textAlign: TextAlign.left,
          textStyle: Theme.of(context).textTheme.headline6,
          // key: Key('Timing_Progress'),
        ),
        FileInfo(fileSize, fileName),
        Heading(
          title: PLEASE_KEEP_THE_APP_OPEN_UNTIL_FILE_IS_DOWNLOADED,
          marginTop: 16.0.h,
          textStyle: Theme.of(context).textTheme.headline6,
          key: Key(APP_MUST_REMAIN_OPEN),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Visible only for Android, as iOS is not supported by file_picker
                if (dartIO.Platform.isAndroid)
                  ButtonWithBackground(
                      handleClicked: () => selectSaveDestination(fileName),
                      title: SAVE_AS,
                      width: 120.0.w,
                      height: 50.0.h,
                      fontSize: 14.0.sp,
                      disabled: false),
                ButtonWithBackground(
                    handleClicked: acceptDownload,
                    title: DOWNLOAD,
                    width: 120.0.w,
                    height: 50.0.h,
                    fontSize: 14.0.sp,
                    disabled: false),
              ],
            ),
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
