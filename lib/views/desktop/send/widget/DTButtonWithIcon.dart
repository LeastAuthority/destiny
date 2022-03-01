import 'package:flutter/material.dart';

class DTButtonWithIcon extends StatelessWidget {
  final String? label;
  final Function? handleSelectFile;
  final Widget? icon;
  final double? width;
  final double? height;
  final bool? isVertical;
  final TextStyle? textStyle;
  DTButtonWithIcon(
      {this.label,
      this.handleSelectFile,
      this.icon,
      this.height,
      this.width,
      this.isVertical,
      required this.textStyle,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
        child: ElevatedButton(
            onPressed: () {
              if (handleSelectFile != null) {
                this.handleSelectFile!();
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).scaffoldBackgroundColor,
              minimumSize: Size.zero,
              maximumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 35,
                  height: 35,
                  child: icon,
                ),
                Text('$label', style: textStyle),
              ],
            )));
  }
}
