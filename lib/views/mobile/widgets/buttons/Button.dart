import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final String title;
  final Function handleClicked;
  final bool disabled;
  final double width;
  final double height;
  final double topMargin;
  Button({
    Key? key,
    required this.handleClicked,
    required this.disabled,
    required this.title,
    this.width = 120.0,
    this.height = 50.0,
    this.topMargin = 22.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: disabled ? 0.75 : 1.00,
        child: Container(
          margin: EdgeInsets.only(top: this.topMargin.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            border: Border.all(
                width: 1.0, color: Theme.of(context).colorScheme.secondary),
          ),
          width: this.width.w,
          height: this.height.h,
          child: TextButton(
            onPressed: () => handleClicked(),
            child: Text('$title', style: Theme.of(context).textTheme.bodyText2),
          ),
        ));
  }
}
