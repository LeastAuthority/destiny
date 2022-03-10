import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final String title;
  final Function handleClicked;
  final bool disabled;
  Button({
    Key? key,
    required this.handleClicked,
    required this.disabled,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: disabled ? 0.75 : 1.00,
        child: Container(
          margin: EdgeInsets.only(top: 22.0.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            border: Border.all(
                width: 1.0, color: Theme.of(context).colorScheme.secondary),
          ),
          width: 120.0.w,
          height: 50.0.h,
          child: TextButton(
            onPressed: () => handleClicked(),
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor),
            child: Text('$title', style: Theme.of(context).textTheme.bodyText2),
          ),
        ));
  }
}
