import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/views/mobile/widgets/FileInfo.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import '../../widgets/DTButton.dart';
import '../../widgets/DTButtonWithBackground.dart';

class DTReceiveConfirmation extends StatelessWidget {
  final String fileName;
  final int fileSize;
  final Function acceptDownload;
  final Function rejectDownload;

  DTReceiveConfirmation(
      this.fileName, this.fileSize, this.acceptDownload, this.rejectDownload);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Heading(
              title: READY_TO_DOWNLOAD,
              textAlign: TextAlign.center,
              textStyle: Theme.of(context).textTheme.headline1,
              // key: Key('Timing_Progress'),
            ),
            SizedBox(
              height: 70.0,
            ),
            FileInfo(fileSize, fileName),
          ],
        ),
        Column(
          children: [
            Heading(
              title: PLEASE_KEEP_THE_APP_OPEN_UNTIL_FILE_IS_DOWNLOADED,
              marginTop: 16.0,
              textStyle: Theme.of(context).textTheme.headline6,
              key: Key(APP_MUST_REMAIN_OPEN),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DTButton(CANCEL, rejectDownload),
                  SizedBox(
                    width: 10.0,
                  ),
                  DTButtonWithBackground(
                    onPressed: () {
                      acceptDownload();
                    },
                    title: DOWNLOAD,
                    width: 120.0,
                    disabled: false,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1.0,
        )
      ],
    );
  }
}
