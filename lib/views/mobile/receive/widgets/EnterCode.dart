
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/ButtonWithBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';

late final TextEditingController controller = new TextEditingController();

class EnterCode extends StatelessWidget {
  Function codeChanged = (String txt) {};
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
          Container(
            width: 300.0.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border(
                    top: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    bottom: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    left: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    right: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 270.0.w,
                  child: TextField(
                    controller: controller,
                    onChanged: (txt) {
                      codeChanged(controller.text);
                    },
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 30.0),
                      hintStyle: Theme.of(context).textTheme.bodyText1,
                      hintText: ENTER_CODE,
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0x000000), width: 0.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0x000000), width: 0.0),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    codeChanged('');
                    controller.text = "";
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('X', style: TextStyle(fontSize: 22.0.sp)),
                      SizedBox(
                        height: 37.0.h,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
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
