import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/ButtonLinearGradientWithIcon.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/ButtonWithIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RowGroupButton extends StatelessWidget {
  final String code;
  final bool isCodeGenerating;
  RowGroupButton(this.code, this.isCodeGenerating);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonLinearGradientWithIcon(
          label: !isCodeGenerating ? code : 'Generating code',
          isCodeGenerating: isCodeGenerating,
          handleSelectFile: () {},
          icon: isCodeGenerating
              ? SpinKitRing(
                  lineWidth: 2.0,
                  color: Colors.white,
                  size: 50.0,
                )
              : null,
          height: 70.0.h,
          width: !isCodeGenerating ? 190.0.w : 260.0.w,
          isVertical: false,
        ),
        SizedBox(
          width: 8.0.w,
        ),
        !isCodeGenerating
            ? ButtonWithIcon(
                fontSize: 10.0.sp,
                fontFamily: Theme.of(context).textTheme.headline2!.fontFamily,
                label: COPY,
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
                height: 70.0.h,
                width: 70.0.w,
                isVertical: true,
              )
            : Container(),
      ],
    );
  }
}
