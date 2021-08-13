import 'package:dart_wormhole_gui/widgets/ButtonLinearGradientWithIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';
import 'ButtonWithIcon.dart';

class RowGroupButton extends StatelessWidget {
  final String label;
  RowGroupButton(this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonLinearGradientWithIcon(
            label:label,
            handleSelectFile: () {},
            icon: CircularProgressIndicator(
              value: 1,
              semanticsLabel: 'Linear progress indicator',
            ),
          height:70.0,
          width: 190.0,
          isVertical: false,
        ),
        SizedBox(
          width: 8.0.w,
        ),
        ButtonWithIcon(
          label:'Copy',
          handleSelectFile: () {},
          icon:Image.asset(
            'assets/images/icons/Paste-white.png',
            width: 30.0.w,
          ),
          height:70.0,
          width: 70.0,
          isVertical: true,
        ),
      ],
    );
  }
}
