import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTButton.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTFileInfo.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'DTRowGroupButton.dart';

class DTCodeGeneration extends StatelessWidget {
  final String fileName;
  final int fileSize;
  final String code;
  final bool isCodeGenerating;

  DTCodeGeneration(
      {Key? key,
      required this.fileName,
      required this.fileSize,
      required this.code,
      required this.isCodeGenerating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border(
          top: BorderSide(width: 2.0, color: CustomColors.purple),
          left: BorderSide(width: 2.0, color: CustomColors.purple),
          right: BorderSide(width: 2.0, color: CustomColors.purple),
          bottom: BorderSide(width: 2.0, color: CustomColors.purple),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              padding: EdgeInsets.only(right: 40.0.w),
              child: SizedBox(
                width: 500.0.w,
                child: Heading(
                  textAlign: TextAlign.center,
                  marginTop: 0,
                  title:
                      SEND_THE_SELECTED_CODE_BY_SHARING_THE_CODE_WITH_RECIPIENT,
                  textStyle: Theme.of(context).textTheme.headline1,
                ),
              )),
          DTFileInfo(fileSize, fileName),
          DTRowGroupButton(code, isCodeGenerating),
          isCodeGenerating
              ? SizedBox(
                  width: 200.0.w,
                  child: Heading(
                    title:
                        SHARE_CODE_WITH_RECIPIENT_AND_WAIT_UNTIL_THE_TRANSFER_IS_COMPLETE,
                    marginTop: 16.0.h,
                    textStyle: Theme.of(context).textTheme.subtitle1,
                    key: Key(GENERATION_DESCRIPTION),
                  ),
                )
              : Heading(
                  title: THE_TRANSFER_WILL_AUTO,
                  marginTop: 16.0.h,
                  textStyle: Theme.of(context).textTheme.subtitle1,
                  key: Key(GENERATION_DESCRIPTION),
                ),
          Column(
            children: [
              isCodeGenerating
                  ? DTButton(
                      CANCEL,
                      () {},
                    )
                  : DTButton(
                      CANCEL,
                      () {},
                    ),
              SizedBox(
                height: 37.0.h,
              )
            ],
          )
        ],
      ),
    );
  }
}
