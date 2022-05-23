import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/ButtonWithBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void doNothing() {
  print("AbortErrorUI button doing nothing");
}

class AbortErrorUI extends StatelessWidget {
  final String text;
  final String subText;
  final Function? handleSelectFile;
  final void Function() onPressed;
  AbortErrorUI(
      {this.text = '',
      this.subText = '',
      this.onPressed = doNothing,
      this.handleSelectFile,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: Theme.of(context).textTheme.headline6),
        Container(
          alignment: Alignment.center,
          child: ButtonWithBackground(
              width: 200.0.w,
              height: 60.0.h,
              title: subText,
              handleClicked: () {
                if (handleSelectFile != null) {
                  this.handleSelectFile!();
                } else {
                  onPressed();
                }
              },
              fontSize: 18.0.sp),
        ),
        SizedBox(
          height: 150.0.h,
        )
      ],
    );
  }
}
