import 'package:dart_wormhole_gui/constants/app_constants.dart';
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
    Widget getCopyButton() {
      if(this.isVertical!)
        return Column( // Replace with a Row for horizontal icon + text
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 35,
              height: 35,
              child: icon,
            ),
            Container(
              child: Text('${label}', style:TextStyle(color: Colors.white, fontSize: 12.sp)),
            ),
          ],
        );
      else
        return Row( // Replace with a Row for horizontal icon + text
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 55,
              height: 55,
              child: icon,
            ),
            Container(
              margin: EdgeInsets.only(right: 8.0.w),
              child: Text('${label}',
                  style:TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: ROBOTO,
                      fontWeight: FontWeight.w500)
              ),
            ),
          ],
        );
    }
    BoxDecoration getBorder () {
      var BORDER_COLOR = this.isVertical!? Colors.white : Color(0xffC24DF8);
      var BACKGEOUND_COLOR = this.isVertical!? Color(0x00ffffff): Color(0xffC24DF8);

      return  BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
      child:  FlatButton(
        onPressed: () {
          if(handleSelectFile != null) {
            this.handleSelectFile!();
          }
        },
        color: Color(0x00353846),
        child: getCopyButton()
      ),
    );
  }
}

