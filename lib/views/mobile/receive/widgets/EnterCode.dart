import 'package:destiny/views/mobile/widgets/buttons/ButtonWithBackground.dart';
import 'package:destiny/widgets/CodeInputBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:destiny/constants/app_constants.dart';

class EnterCode extends StatelessWidget {
  final Function codeChanged;
  final Function handleNextClicked;
  final bool isRequestingConnection;
  final TextEditingController controller;
  final void Function(String) onEnterPressed;
  EnterCode(
      {Key? key,
      required this.codeChanged,
      required this.handleNextClicked,
      required this.isRequestingConnection,
      required final this.controller,
      required this.onEnterPressed})
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
              },
              onEnterPressed: onEnterPressed),
          controller.text.length > 0 && !isRequestingConnection
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
                  title: isRequestingConnection ? 'Please wait...' : NEXT,
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
