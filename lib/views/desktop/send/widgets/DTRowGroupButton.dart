import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widgets/DTButtonLinearGradientWithIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
              ? SpinKitRing(
                  lineWidth: 2.0,
                  color: Colors.white,
                  size: 50.0,
                )
              : null,
          height: 60.0,
          width: !isCodeGenerating ? 350.0 : 400.0,
        ),
        SizedBox(
          width: 8.0,
        ),
        !isCodeGenerating
            ? DTButtonWithIcon(
                label: 'Copy',
                textStyle: TextStyle(
                  fontFamily: Theme.of(context).textTheme.headline5?.fontFamily,
                  color: Theme.of(context).textTheme.headline5?.color,
                  fontSize: 12.0,
                ),
                handleSelectFile: () {
                  Clipboard.setData(ClipboardData(text: code));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(CODE_COPIED),
                  ));
                },
                icon: Image.asset(
                  COPY_ICON,
                  width: 30.0,
                  height: 30.0,
                ),
                width: 50.0,
                height: 60.0,
                isVertical: true,
              )
            : Container(),
      ],
    );
  }
}
