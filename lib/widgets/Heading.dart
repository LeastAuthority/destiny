import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Heading extends StatelessWidget {
  String? title;
  String? subTitle;
  TextAlign? textAlign;
  double marginTop = 0.0;
  double? fontSize;
  String? fontFamily;
  FontWeight? fontWeight;
  Heading({Key? key, String? title, String? subTitle, TextAlign? textAlign, double marginTop=0, double? fontSize, String? fontFamily, FontWeight? fontWeight}):super(key:key) {
    this.title = title;
    this.subTitle = subTitle;
    this.textAlign = textAlign;
    this.marginTop = marginTop;
    this.fontSize = fontSize;
    this.fontFamily = fontFamily;
    this.fontWeight = fontWeight;
  }
  @override
  Widget build(BuildContext context) {
    if(subTitle == null)
      return  Container(
        width: double.infinity,
        margin: EdgeInsets.only(top:marginTop),
        child: Text('${title}',
          textAlign: textAlign,
          style:TextStyle(
              color: Color(0xFFFDFCFC),
              fontSize: fontSize,
              fontFamily: fontFamily,
              fontWeight: fontWeight
          ),
        ),
      );

    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top:marginTop),
          child: Text('${title}',
            textAlign: textAlign,
            style:TextStyle(
                color: Color(0xFFFDFCFC),
                fontSize: fontSize,
                fontFamily: fontFamily,
                fontWeight: fontWeight
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top:marginTop),
          child: Text('${subTitle}',
            textAlign: textAlign,
            style:TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }
}
