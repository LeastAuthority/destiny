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
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 100.0,
            height: 150.0.h,
            child: TextField(
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.bodyText1,
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0
                  ),
                ),
                hintText: 'Enter Code',
              ),
            ),
          ),
          Button(NEXT, () {
            //FIXME
            //Here we call a function to start receiving a file. The function takes the generated code as parameter.
            //Note that the UI here is not ready. So maybe we should pass a static code to the fun
          }),
          Button(CANCEL, () {}),
        ],
      ),
    );
  }
}
