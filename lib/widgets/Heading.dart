import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  String? title;
  String? subTitle;
  TextAlign? textAlign;
  double marginTop = 0.0;
  TextStyle? textStyle;
  Heading({
    Key? key,
    String? title,
    String? subTitle,
    TextAlign? textAlign,
    double marginTop=0,
    TextStyle? textStyle
  }):super(key:key) {
    this.title = title;
    this.subTitle = subTitle;
    this.textAlign = textAlign;
    this.marginTop = marginTop;
    this.textStyle = textStyle;
  }
  @override
  Widget build(BuildContext context) {
    if(subTitle == null)
      return  Container(
        width: double.infinity,
        margin: EdgeInsets.only(top:marginTop),
        child: Text('${title}',
          textAlign: textAlign,
            style: textStyle
        ),
      );

    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top:marginTop),
          child: Text('${title}',
            textAlign: textAlign,
            style: textStyle
          ),
        ),
      ],
    );
  }
}
