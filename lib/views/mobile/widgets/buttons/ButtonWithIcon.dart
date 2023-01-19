import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWithIcon extends StatelessWidget {
  final String? label;
  final Function? handleSelectFile;
  final Widget? icon;
  final double? width;
  final double? height;
  final bool? isVertical;
  final double? fontSize;
  final String? fontFamily;
  ButtonWithIcon(
      {this.label,
      this.handleSelectFile,
      this.icon,
      this.height,
      this.width,
      this.isVertical,
      required this.fontSize,
      required this.fontFamily,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getButtonContent() {
      if (this.isVertical!)
        return ElevatedButton(
            onPressed: () {
              if (handleSelectFile != null) {
                this.handleSelectFile!();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 35,
                  height: 35,
                  child: icon,
                ),
                Container(
                  child: Text('$label',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
              ],
            ));
      else
        return TextButton(
            onPressed: () {
              if (handleSelectFile != null) {
                this.handleSelectFile!();
              }
            },
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 4.0.w),
                  width: 20.0.w,
                  height: 25.0.h,
                  child: icon,
                ),
                Container(
                  child: Text('$label',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                          fontFamily: fontFamily)),
                ),
              ],
            ));
    }

    BoxDecoration getBorder() {
      var borderColor = this.isVertical!
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).primaryColor;

      var backgroundColor = this.isVertical!
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).primaryColor;

      return BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: backgroundColor,
          border: Border.all(width: 1.0, color: borderColor));
    }

    return Container(
        decoration: getBorder(),
        width: width,
        height: height,
        margin: const EdgeInsets.only(top: 30.0),
        child: getButtonContent());
  }
}
