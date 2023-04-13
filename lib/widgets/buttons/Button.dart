import 'package:destiny/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final String? title;
  final Function handleSelectFile;
  final bool? disabled;
  final double? width;
  final double? height;
  final Color? bgColor;

  Button(this.title, this.handleSelectFile, this.disabled, this.height,
      this.width, this.bgColor);

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
      width: width,
      height: height,
      child: TextButton(
          onPressed: () => this.handleSelectFile(),
          style: TextButton.styleFrom(
              backgroundColor: bgColor, padding: EdgeInsets.all(0)),
          child: Text('$title',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: color))),
    );
  }
}
