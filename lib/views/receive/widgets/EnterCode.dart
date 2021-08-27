import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/send/widgets/RowGroupButtons.dart';
import '../../../widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';

class EnterCode extends StatelessWidget {
  // String? fileName = '';
  // int? fileSize = 0;
  //
  // EnterCode({Key? key, String? fileName, int? fileSize}):super(key:key) {
  //   this.fileName = fileName;
  //   this.fileSize = fileSize;
  // }
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
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 14.0, color: Colors.white, ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0XffC24DF8), width: 1.0),
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
          // SizedBox(
          //   height: 100.h,
          // ),
        ],
      ),
    );
  }
}
