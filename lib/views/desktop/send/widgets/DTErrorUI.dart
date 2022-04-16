import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DTErrorUI extends StatelessWidget {
  final String text;
  final String subText;
  DTErrorUI({this.text = '', this.subText = '', Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 2.0, color: CustomColors.purple),
        ),
        padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, top: 80.0.h),
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
            )
          ],
        ));
  }
}
