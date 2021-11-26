import 'package:dart_wormhole_gui/views/desktop/send/widget/DTButtonLinearGradientWithIcon.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/ButtonLinearGradientWithIcon.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/ButtonWithIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';

class DTRowGroupButton extends StatelessWidget {
  String code = '';
  bool isCodeGenerating = false;
  DTRowGroupButton(this.code, this.isCodeGenerating);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DTButtonLinearGradientWithIcon(
            label: !isCodeGenerating ? code: 'Generating code',
            isCodeGenerating: isCodeGenerating,
            handleSelectFile: () {},
            icon: isCodeGenerating ? CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
              value: 0.75,
              semanticsLabel: 'Linear progress indicator',
            ): null,
          height: 50.0.h,
          width: !isCodeGenerating?190.0.w:260.0.w,
          isVertical: false,
        ),
        SizedBox(
          width: 8.0.w,
        ),
        !isCodeGenerating ? ButtonWithIcon(
          label:'Copy',
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
        ): Container(),
      ],
    );
  }
}
