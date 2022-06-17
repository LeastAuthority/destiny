import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTButtonWithBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/util.dart';

void doNothing() {
  print("Doing nothing with error UI button");
}

class DTErrorUI extends StatelessWidget {
  final String text;
  final String subText;
  final String buttonTitle;
  final double paddingTop;
  final void Function() onPressed;
  final bool? showBoxDecoration;

  DTErrorUI(
      {this.text = '',
      this.subText = '',
      this.showBoxDecoration = false,
      this.onPressed = doNothing,
      this.buttonTitle = '',
      this.paddingTop = 0.0,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: showBoxDecoration == true
            ? BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(width: 2.0, color: CustomColors.purple),
              )
            : null,
        padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, top: paddingTop),
        child: Column(children: [
          ...convertErrorMessageIntoParagraphs(text,
              Theme.of(context).textTheme.headline1, TextAlign.center, context),
          Text(
            subText,
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 100.0.h,
          ),
          DTButtonWithBackground(
            onPressed: onPressed,
            title: buttonTitle,
            width: 150.0,
            disabled: false,
          )
        ]));
  }
}
