import 'package:destiny/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatefulWidget {
  final String title;
  final Function handleSelectFile;
  final bool? disabled;
  Button(this.title, this.handleSelectFile, this.disabled);
  @override
  _CustomAppBarState createState() =>
      _CustomAppBarState(title, handleSelectFile, disabled);
}

class _CustomAppBarState extends State<Button> {
  final String title;
  Function handleSelectFile;
  Widget? icon;
  bool? disabled;
  _CustomAppBarState(this.title, this.handleSelectFile, this.disabled);

  @override
  Widget build(BuildContext context) {
    Color? color = disabled == true
        ? Theme.of(context).primaryColor
        : Theme.of(context).textTheme.bodyText2!.color;
    return Container(
      margin: EdgeInsets.only(top: 22.0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(width: 1.0, color: CustomColors.babyPowder),
      ),
      width: 120.0.w,
      height: 50.0.h,
      child: TextButton(
        onPressed: () => handleSelectFile(),
        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        child: Text('$title',
            style: TextStyle(
              color: color,
              fontWeight: Theme.of(context).textTheme.bodyText2!.fontWeight,
              fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
              fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily,
            )),
      ),
    );
  }
}
