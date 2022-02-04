import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWithBackground extends StatelessWidget {

  Function handleClicked = () {};
  String title = '';
  bool? disabled = false;
  double? width = 120.0.w;
  double? height = 50.0.h;

  ButtonWithBackground(
      {required String title,
      required Function handleClicked,
      bool? disabled,
      double? width,
      double? height,
      Key? key})
      : super(key: key) {
    this.handleClicked = handleClicked;
    this.title = title;
    this.disabled = disabled;
    if (width != null) {
      this.width = width;
    }
    if (height != null) {
      this.height = height;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget getButtonContent() {
      return GestureDetector(
          onTap: () {
            this.handleClicked();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Theme.of(context).textTheme.headline1!.fontSize,
                      fontWeight:
                          Theme.of(context).textTheme.headline1!.fontWeight,
                      fontFamily:
                          Theme.of(context).textTheme.headline1!.fontFamily,
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
