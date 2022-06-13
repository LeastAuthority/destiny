import 'package:flutter/material.dart';

class ButtonWithBackground extends StatelessWidget {
  final Function handleClicked;
  final String title;
  final bool? disabled;
  final double? width;
  final double? height;
  final double fontSize;
  ButtonWithBackground(
      {required this.title,
      required this.handleClicked,
      this.disabled = false,
      this.width,
      this.height,
      required this.fontSize,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget getButtonContent() {
      var enabledBackgroundColor = Theme.of(context).primaryColor;
      var disabledBackgroundColor = Theme.of(context).primaryColorDark;
      var backgroundColor =
      disabled == true ? disabledBackgroundColor : enabledBackgroundColor;
      return TextButton(
          onPressed: () {
            if (disabled == false) this.handleClicked();
          },
          style: TextButton.styleFrom(
              backgroundColor: backgroundColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(title,
                    style: TextStyle(
                        fontSize: fontSize,
                        fontFamily:
                            Theme.of(context).textTheme.headline2?.fontFamily,
                        color: Theme.of(context).textTheme.headline2?.color
                    )),
              ),
            ],
          ));
    }

    BoxDecoration getBorder() {
      var enabledBorderColor = Theme.of(context).primaryColor;
      var disabledBorderColor = Theme.of(context).primaryColorDark;
      var borderColor =
          disabled == true ? disabledBorderColor : enabledBorderColor;
      return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(width: 1.0, color: borderColor),
      );
    }

    return Container(
        decoration: getBorder(),
        height: height,
        width: width,
        margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: getButtonContent());
  }
}
