import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'RowGroupButtons.dart';

class CodeGeneration extends StatelessWidget {
  final String fileName;
  final int fileSize;
  final String? code;
  final bool isCodeGenerating;
  Function cancelSend;
  CodeGeneration(this.fileName, this.fileSize, this.code, this.isCodeGenerating,
      this.cancelSend,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(right: 40.0.w),
          child: Heading(
            title: SEND_THE_SELECTED_CODE_BY_SHARING_THE_CODE_WITH_RECIPIENT,
            textAlign: TextAlign.left,
            marginTop: 0,
            textStyle: Theme.of(context).textTheme.bodyText1,
            key: Key(SEND_SCREEN_HEADING),
          ),
        ),
        Column(
          children: [
            FileInfo(fileSize, fileName),
            RowGroupButton(code ?? "", isCodeGenerating),
            isCodeGenerating
                ? Heading(
                    title:
                        SHARE_CODE_WITH_RECIPIENT_AND_WAIT_UNTIL_THE_TRANSFER_IS_COMPLETE,
                    textAlign: TextAlign.center,
                    marginTop: 16.0.h,
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    key: Key(GENERATION_DESCRIPTION),
                  )
                : Heading(
                    title: THE_TRANSFER_WILL_AUTO,
                    textAlign: TextAlign.center,
                    marginTop: 16.0.h,
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    key: Key(GENERATION_DESCRIPTION),
                  )
          ],
        ),
        Column(
          children: [
            Button(
              title: CANCEL,
              handleClicked: cancelSend,
              disabled: true,
            ),
            SizedBox(
              height: 37.0.h,
            )
          ],
        )
      ],
    );
  }
}
