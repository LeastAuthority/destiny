import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTButton.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTFileInfo.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'DTRowGroupButton.dart';

class DTCodeGeneration extends StatelessWidget {
  final String fileName;
  final int fileSize;
  final String code;
  final bool isCodeGenerating;
  final CancelFunc cancelFunc;

  DTCodeGeneration(
      {Key? key,
      required this.fileName,
      required this.fileSize,
      required this.code,
      required this.isCodeGenerating,
      required this.cancelFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(width: 2.0, color: CustomColors.purple),
      ),
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 80.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: SizedBox(
            width: 500.0,
            child: Heading(
              title: SEND_THE_SELECTED_CODE_BY_SHARING_THE_CODE_WITH_RECIPIENT,
              textStyle: Theme.of(context).textTheme.headline1,
            ),
          )),
          DTFileInfo(fileSize, fileName),
          DTRowGroupButton(code, isCodeGenerating),
          SizedBox(
            width: 380.0,
            child: Heading(
              title: THE_TRANSFER_WILL_AUTO,
              marginTop: 40.0,
              textStyle: Theme.of(context).textTheme.subtitle1,
              key: Key(GENERATION_DESCRIPTION),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          isCodeGenerating
              ? DTButton(
                  CANCEL,
                  () {},
                )
              : DTButton(CANCEL, () {
                  cancelFunc();
                }),
          SizedBox(
            height: 150.0,
          )
        ],
      ),
    );
  }
}
