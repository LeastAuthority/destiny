import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/widgets/buttons/Button.dart';

class EnterCode extends StatelessWidget {
  EnterCode({Key? key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
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
          SizedBox(height:25.0.h),
          Button(NEXT, () {
            //FIXME
            //Here we call a function to start receiving a file. The function takes the generated code as parameter.
            //Note that the UI here is not ready. So maybe we should pass a static code to the fun
          }),
          // Button(CANCEL, () {}),
        ],
      ),
    );
  }
}
