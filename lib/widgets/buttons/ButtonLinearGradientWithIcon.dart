import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:basic_utils/basic_utils.dart';

class ButtonLinearGradientWithIcon extends StatelessWidget {
  String label = '';
  Function? handleSelectFile;
  Widget? icon;
  double? width;
  double? height;
  bool? isVertical;

  ButtonLinearGradientWithIcon({
    String label = '', Function? handleSelectFile,
    Widget? icon, double? height,
    double? width, bool? isVertical,
    Key? key}):super(key:key) {
    int middleIndex = (label.length / 2).toInt();
    this.label = StringUtils.addCharAtPosition(label, "\n", middleIndex);
    this.isVertical = isVertical;
    this.handleSelectFile = handleSelectFile;
    this.icon = icon;
    this.height = height;
    this.width = width;
  }

  @override
  Widget build(BuildContext context) {

    BoxDecoration getBorder () {
      var BORDER_COLOR = this.isVertical!?
        Theme.of(context).colorScheme.secondary :
         Theme.of(context).primaryColor;
      return  BoxDecoration(
       borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(width: 2.0, color: BORDER_COLOR),
          left: BorderSide(width: 2.0, color: BORDER_COLOR),
          right: BorderSide(width: 2.0, color: BORDER_COLOR),
          bottom: BorderSide(width: 2.0, color: BORDER_COLOR),
        ),
      );
    }
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 30.0),
       decoration:  BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(10.0)),
         border: Border(
           top: BorderSide(width: 2.0, color:  Color(0x00C24DF8)),
           left: BorderSide(width: 2.0, color:  Color(0x00C24DF8)),
           right: BorderSide(width: 2.0, color:  Color(0x00C24DF8)),
           bottom: BorderSide(width: 2.0, color:  Color(0x00C24DF8)),
         ),
         gradient: LinearGradient(
           begin: Alignment.centerLeft,
           colors: <Color>[
             Theme.of(context).primaryColor,
             CustomColors.lightBlue
           ], // red to yellow
           tileMode: TileMode.repeated, // repeats the gradient over the canvas
         ),
       ),
      child: Container(
        decoration: getBorder(),
        width: width,
        height: height,
        child:  FlatButton(
            onPressed: () {
              if(handleSelectFile != null) {
                this.handleSelectFile!();
              }
            },
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SizedBox(
              child:Row( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text(
                        '${label}',
                        textAlign: TextAlign.center,
                        style:Theme.of(context).textTheme.bodyText2
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:  SizedBox(
                      width: 25,
                      height: 25,
                      child: icon,
                    ),)
                ],
              ),
            )
        ),
      ),
    );
  }
}

