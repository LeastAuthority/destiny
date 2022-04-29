import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/DTButtonWithBackground.dart';

class DTErrorUI extends StatelessWidget {
  final String text;
  final String subText;
  final String route;
  final String buttonTitle;
  final double paddingTop;
  bool? showBoxDecoration = false;
  DTErrorUI(
      {this.text = '',
      this.subText = '',
      this.showBoxDecoration,
      this.route = '',
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
        child: Column(
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0.h,
            ),
            Text(
              subText,
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 100.0.h,
            ),
            DTButtonWithBackground(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  route,
                );
              },
              title: buttonTitle,
              width: 150.0,
              disabled: false,
            )
          ],
        ));
  }
}
