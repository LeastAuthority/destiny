import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/send/widgets/RowGroupButtons.dart';
import 'package:dart_wormhole_gui/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';

class CodeGeneration extends StatelessWidget {
  String? fileName = '';
  int? fileSize = 0;
  String code = '';
  CodeGeneration({Key? key, String? fileName, int? fileSize, String code = ''}):super(key:key) {
    this.fileName = fileName;
    this.fileSize = fileSize;
    this.code = code;
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: SEND_THE_SELECTED_CODE_BY_SHARING_THE_CODE_WITH_RECIPIENT,
          textAlign: TextAlign.left,
          marginTop: 0,
          textStyle: Theme.of(context).textTheme.bodyText1,
          key: Key(SEND_SCREEN_HEADING),
        ),
        Column(
          children: [
            FileInfo(fileSize, fileName),
            RowGroupButton(GENERATION_CODE, code),
            Heading(
              title: SHARE_CODE_WITH_RECIPIENT_AND_WAIT_UNTIL_THE_TRANSFER_IS_COMPLETE,
              textAlign:TextAlign.center,
              marginTop: 16.0.h,
              textStyle: Theme.of(context).textTheme.bodyText2,
              key:Key(GENERATION_DESCRIPTION),
            )
          ],
        ),
        Column(
          children: [
            Button(CANCEL, () {
            }),
            SizedBox(
              height: 37.0.h,
            )
          ],
        )
      ],
    );
  }
}
