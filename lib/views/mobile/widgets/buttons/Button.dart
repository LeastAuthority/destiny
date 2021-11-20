import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  String title = '';
  Function handleSelectFile = () {};
  bool disabled = false;
  Button({
    Key? key,
    required Function handleSelectFile,
    required bool disabled,
    required String title,
  }):super(key:key){
    this.handleSelectFile = handleSelectFile;
    this.title = title;
    this.disabled = disabled;
  }
  @override
  Widget build(BuildContext context) {
    return  Opacity (
      opacity: disabled? 0.75: 1.00,
      child: Container(
        margin: EdgeInsets.only(top:22.0.h),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border(
            top: BorderSide(width: 1.0, color: Color(0xFFFDFAFA)),
            left: BorderSide(width: 1.0, color: Color(0xFFFDFAFA)),
            right: BorderSide(width: 1.0, color:  Color(0xFFFDFAFA)),
            bottom: BorderSide(width: 1.0, color:  Color(0xFFFfDFAFA)),
          ),
        ),
        width: 120.0.w,
        height: 50.0.h,
        child:  FlatButton(
          onPressed: () => handleSelectFile(),
          color: Theme.of(context).scaffoldBackgroundColor,
          child:Text('${title}',
              style: Theme.of(context).textTheme.bodyText2
          ),
        ),
      )
    );
  }
}

