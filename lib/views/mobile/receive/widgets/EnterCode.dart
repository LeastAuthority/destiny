import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/ButtonWithBackground.dart';
import 'package:dart_wormhole_gui/widgets/CodeInputBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';

late final TextEditingController controller = new TextEditingController();

class EnterCode extends StatelessWidget {
  Function codeChanged = () {};
  Function handleNextClicked = (String txt) {};
  EnterCode({
    Key? key,
    required Function codeChanged,
    required Function handleNextClicked,
  }) : super(key: key) {
    this.codeChanged = codeChanged;
    this.handleNextClicked = handleNextClicked;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CodeInputBox(
              controller: controller,
              width: 300.0.w,
              codeChanged: (String code) {
                codeChanged(code);
              }),
          controller.text.length > 0
              ? ButtonWithBackground(
                  title: NEXT,
                  handleClicked: handleNextClicked,
                  disabled: false,
                  key: Key(RECEIVE_SCREEN_NEXT_BTN_ENABLED))
              : ButtonWithBackground(
                  title: NEXT,
                  handleClicked: handleNextClicked,
                  disabled: true,
                  key: Key(RECEIVE_SCREEN_NEXT_BTN_ENABLED)),
          SizedBox(height: 8.0.h),
        ],
      ),
    );
  }
}
