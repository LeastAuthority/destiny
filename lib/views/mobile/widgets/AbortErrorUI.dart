import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'buttons/ButtonWithBackground.dart';

class AbortErrorUI extends StatelessWidget {
  final String text;
  final String subText;
  final String route;
  final Function? handleSelectFile;
  AbortErrorUI(
      {this.text = '',
      this.subText = '',
      this.route = '',
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
                  Navigator.pushReplacementNamed(
                    context,
                    route,
                  );
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
