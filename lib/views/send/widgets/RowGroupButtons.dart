import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/widgets/buttons/ButtonLinearGradientWithIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';
import '../../../widgets/buttons/ButtonWithIcon.dart';
import 'package:flutter/services.dart';

class RowGroupButton extends StatelessWidget {
  final String label;
  String code = '';
  RowGroupButton(this.label, this.code);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonLinearGradientWithIcon(
            label: code,
            handleSelectFile: () {},
            icon: CircularProgressIndicator(
              value: 1,
              semanticsLabel: 'Linear progress indicator',
            ),
          height: 70.0,
          width: 190.0,
          isVertical: false,
        ),
        SizedBox(
          width: 8.0.w,
        ),
        ButtonWithIcon(
          label:'Copy',
          handleSelectFile: () {
            Clipboard.setData(ClipboardData(text: code));
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Code Copied"),
            // ));
          },
          icon:Image.asset(
            COPY_ICON,
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
