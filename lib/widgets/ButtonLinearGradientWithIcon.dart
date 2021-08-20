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
              child: Text('${label}', style:TextStyle(color: Colors.white, fontSize: 8.sp, )),
            ),
          ],
        );
      else
        return SizedBox(
          child:Row( // Replace with a Row for horizontal icon + text
            children: <Widget>[
              Expanded(
                flex: 5,
               // margin: EdgeInsets.only(right: 8.0.w),
                child: Text(
                    '${label}',
                    textAlign: TextAlign.center,
                    style:TextStyle(color: Colors.white, fontSize: 12.sp)
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
        );
    }
    BoxDecoration getBorder () {
      // var BORDER_COLOR = this.isVertical!? Colors.white : Color(0xffC24DF8);
      var BORDER_COLOR = this.isVertical!? Colors.white : Color(0x00C24DF8);

      return  BoxDecoration(
       borderRadius: BorderRadius.all(Radius.circular(10.0)),
         color: Colors.black,
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
             Color(0xffC24DF8),
             Color(0xff33B6FF)
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
            color: Color(0x00353846),
            child: getCopyButton()
        ),
      ),
    );
  }
}

