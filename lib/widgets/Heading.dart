import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Heading extends StatelessWidget {
  //this component needs a lot of enhancements
  String? title;
  TextAlign? textAlign;
  double marginTop = 0.0;
  double? fontSize;
  String? fontFamily;
  FontWeight? fontWeight;
  Heading({Key? key, String? title, TextAlign? textAlign, double marginTop=0, double? fontSize, String? fontFamily, FontWeight? fontWeight}):super(key:key) {
    this.title = title;
    this.textAlign = textAlign;
    this.marginTop = marginTop;
    this.fontSize = fontSize;
    this.fontFamily = fontFamily;
    this.fontWeight = fontWeight;
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.only(top:marginTop),
          child: Text('${title}',
            textAlign: textAlign,
            style:TextStyle(color: Colors.white, fontSize: fontSize, fontFamily: fontFamily, fontWeight: fontWeight),
          ),
    );
  }
}
