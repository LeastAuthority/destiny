import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/ButtonWithBackground.dart';
import 'package:dart_wormhole_gui/widgets/CodeInputBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';

class EnterCode extends StatelessWidget {
  final Function codeChanged;
  final Function handleNextClicked;
  final TextEditingController controller;
  EnterCode(
      {Key? key,
      required this.codeChanged,
      required this.handleNextClicked,
      required final this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CodeInputBox(
              controller: controller,
              style: Theme.of(context).textTheme.headline6,
              width: 300.0.w,
              codeChanged: (String code) {
                codeChanged(code);
              }),
          controller.text.length > 0
              ? ButtonWithBackground(
                  fontSize: 14.0.sp,
                  title: NEXT,
                  handleClicked: handleNextClicked,
                  disabled: false,
                  width: 120.0.w,
                  height: 50.0.h,
                  key: Key(RECEIVE_SCREEN_NEXT_BTN_ENABLED))
              : ButtonWithBackground(
                  fontSize: 14.0.sp,
                  title: NEXT,
                  handleClicked: handleNextClicked,
                  disabled: true,
                  width: 120.0.w,
                  height: 50.0.h,
                  key: Key(RECEIVE_SCREEN_NEXT_BTN_ENABLED)),
          SizedBox(height: 8.0.h),
        ],
      ),
    );
  }
}
