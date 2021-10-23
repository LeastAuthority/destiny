import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWithIcon extends StatelessWidget {
  String? label;
  Function? handleSelectFile;
  Widget? icon;
  double? width;
  double? height;
  bool? isVertical;
  bool _flag = false;
  ButtonWithIcon({
    String? label, Function? handleSelectFile,
    Widget? icon, double? height,
    double? width, bool? isVertical,
    Key? key}):super(key:key) {

    this.label = label;
    this.isVertical = isVertical;
    this.handleSelectFile = handleSelectFile;
    this.icon = icon;
    this.height = height;
    this.width = width;
  }

  @override
  Widget build(BuildContext context) {
    Widget getButtonContent() {
      if(this.isVertical!)
        return ElevatedButton(
            onPressed: () {
              if(handleSelectFile != null) {
                this.handleSelectFile!();
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).scaffoldBackgroundColor,
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
                  child: Text(
                      '${label}',
                      style: Theme.of(context).textTheme.bodyText2
                  ),
                ),
              ],
            )
        );
      else
        return FlatButton(
            onPressed: () {
              if(handleSelectFile != null) {
                this.handleSelectFile!();
              }
            },
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 36,
                  height: 36,
                  child: icon,
                ),
                Container(
                  child: Text('${label}',
                      style: Theme.of(context).textTheme.headline1
                  ),
                ),
              ],
            )
        );

    }
    BoxDecoration getBorder () {
      var BORDER_COLOR = this.isVertical!?
       Theme.of(context).colorScheme.secondary :
        Theme.of(context).primaryColor;

      var BACKGEOUND_COLOR = this.isVertical!?
       Theme.of(context).colorScheme.secondary :
         Theme.of(context).primaryColor;

      return  BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: BACKGEOUND_COLOR,
        border: Border(
          top: BorderSide(width: 1.0, color: BORDER_COLOR),
          left: BorderSide(width: 1.0, color: BORDER_COLOR),
          right: BorderSide(width: 1.0, color: BORDER_COLOR),
          bottom: BorderSide(width: 1.0, color: BORDER_COLOR),
        ),
      );
    }
    return Container(
      decoration: getBorder(),
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 30.0),
      child: getButtonContent()
    );
  }
}
