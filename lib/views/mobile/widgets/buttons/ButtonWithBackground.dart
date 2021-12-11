import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWithBackground extends StatelessWidget {
  Function? handleSelectFolder;
  ButtonWithBackground({Function? handleSelectFolder, double? height, Key? key})
      : super(key: key) {
    this.handleSelectFolder = handleSelectFolder;
  }

  @override
  Widget build(BuildContext context) {
    Widget getButtonContent() {
      return FlatButton(
          onPressed: () {
            if (handleSelectFolder != null) {
              this.handleSelectFolder!();
            }
          },
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text('$SELECT_A_FOLDER',
                    style: Theme.of(context).textTheme.headline1),
              ),
            ],
          ));
    }

    BoxDecoration getBorder() {
      var borderColor = Theme.of(context).primaryColor;
      var backgroundColor = Theme.of(context).primaryColor;

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
        height: 60.0.h,
        width: 200.0.w,
        margin: const EdgeInsets.only(top: 30.0),
        child: getButtonContent());
  }
}
