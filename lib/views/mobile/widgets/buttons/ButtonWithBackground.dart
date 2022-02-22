import 'package:flutter/material.dart';

class ButtonWithBackground extends StatelessWidget {
  final Function handleClicked;
  final String title;
  final bool? disabled;
  final double? width;
  final double? height;
  ButtonWithBackground(
      {required this.title,
      required this.handleClicked,
      this.disabled = false,
      this.width,
      this.height,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget getButtonContent() {
      return GestureDetector(
          onTap: () {
            if (disabled == false) this.handleClicked();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Theme.of(context).textTheme.headline2!.fontSize,
                      fontFamily:
                          Theme.of(context).textTheme.headline2!.fontFamily,
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

      var enabledBackgroundColor = Theme.of(context).primaryColor;
      var disabledBackgroundColor = Theme.of(context).primaryColorDark;
      var backgroundColor =
          disabled == true ? disabledBackgroundColor : enabledBackgroundColor;

      return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: backgroundColor,
        border: Border(
          top: BorderSide(width: 1.0, color: borderColor),
          left: BorderSide(width: 1.0, color: borderColor),
          right: BorderSide(width: 1.0, color: borderColor),
          bottom: BorderSide(width: 1.0, color: borderColor),
        ),
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
