import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
late final TextEditingController controller = new TextEditingController();

class EnterCode extends StatelessWidget {
  Function codeChanged = (String txt) {};
  Function handleNextClicked = (String txt) {};
  String _code = '';

  EnterCode({
    Key? key,
    required Function codeChanged,
    required Function handleNextClicked,
  }):super(key:key){
    this.codeChanged = codeChanged;
    this.handleNextClicked = handleNextClicked;
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                contentPadding: const EdgeInsets.symmetric(vertical: 30.0),
                hintStyle: Theme.of(context).textTheme.bodyText1,
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color(0xffC24DF8),
                      width: 1.0
                  ),
                ),
                hintText: 'Enter Code',
              ),
            ),
          ),
          SizedBox(height: 25.0.h),
          controller.text.length > 0 ?
             Column(
               children: [
                 Button(
                     title: NEXT,
                     handleSelectFile: handleNextClicked,
                     disabled: false,
                     key: Key(RECEIVE_SCREEN_NEXT_BTN_ENABLED)
                 ),
                 Button(
                   title: CANCEL,
                   handleSelectFile: (){
                     print('dddddd');
                     codeChanged('');
                     controller.text = "";
                   },
                   disabled: false,
                   // key: Key(RECEIVE_SCREEN_NEXT_BTN_DISABLED)
                 )
               ],
             ):
          Column(
            children: [
              Button(
                  title: NEXT,
                  handleSelectFile: handleNextClicked,
                  disabled: true,
                  key: Key(RECEIVE_SCREEN_NEXT_BTN_ENABLED)
              ),
              Button(
                  title: CANCEL,
                  handleSelectFile: (){},
                  disabled: true,
                  key: Key(RECEIVE_SCREEN_NEXT_BTN_DISABLED)
              ),
            ],
          )
        ],
      ),
    );
  }
}
