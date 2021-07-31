import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescriptionContainer extends StatelessWidget {
  //this component needs a lot of enhancements
   String? title;
   TextAlign? textAlign;
   double? marginTop;
   double? fontSize;
  // DescriptionContainer(this.title, this.textAlign, this.marginTop, this.fontSize, Key key):super(key:key);
  DescriptionContainer({Key? key, String? title, TextAlign? textAlign, double? marginTop, double? fontSize}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.only(top:marginTop!),
          child: Text('${title}',
            textAlign: textAlign,
            style:TextStyle(color: Colors.white, fontSize: fontSize,),
          ),
    );
  }
}
