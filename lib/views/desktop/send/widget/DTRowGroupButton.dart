import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widget/DTButtonLinearGradientWithIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'DTButtonWithIcon.dart';

class DTRowGroupButton extends StatelessWidget {
  final String code;
  final bool isCodeGenerating;

  DTRowGroupButton(this.code, this.isCodeGenerating);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DTButtonLinearGradientWithIcon(
          label: isCodeGenerating ? 'Generating code' : code,
          isCodeGenerating: isCodeGenerating,
          handleSelectFile: () {},
          icon: isCodeGenerating
              ? CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                  value: 0.75,
                  semanticsLabel: 'Linear progress indicator',
                )
              : null,
          height: 60.0.h,
          width: !isCodeGenerating ? 350.0.w : 400.0.w,
        ),
        SizedBox(
          width: 8.0.w,
        ),
        !isCodeGenerating
            ? DTButtonWithIcon(
                label: 'Copy',
                handleSelectFile: () {
                  Clipboard.setData(ClipboardData(text: code));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(CODE_COPIED),
                  ));
                },
                icon: Image.asset(
                  COPY_ICON,
                  width: 30.0.w,
                  height: 30.0.h,
                ),
                width: 50.0.w,
                height: 60.0.h,
                isVertical: true,
              )
            : Container(),
      ],
    );
  }
}
