import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DTButton extends StatefulWidget {
  final String title;
  Function handleSelectFile;
  DTButton(this.title, this.handleSelectFile);

  @override
  _CustomAppBarState createState() => _CustomAppBarState(title, handleSelectFile);
}

class _CustomAppBarState extends State<DTButton> {
  final String title;
  Function handleSelectFile;
  Widget? icon;
  _CustomAppBarState(this.title, this.handleSelectFile);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border(
          top: BorderSide(width: 1.0, color: Color(0xFFbfbfbf)),
          left: BorderSide(width: 1.0, color: Color(0xFFbfbfbf)),
          right: BorderSide(width: 1.0, color:  Color(0xFFbfbfbf)),
          bottom: BorderSide(width: 1.0, color:  Color(0xFFbfbfbf)),
        ),
      ),
      width: 100.0.w,
      height: 30.0.h,
      child:  FlatButton(
        onPressed: () => handleSelectFile(),
        color: Theme.of(context).scaffoldBackgroundColor,
        child:Text('${title}',
            style: Theme.of(context).textTheme.subtitle1
        ),
      ),
    );
  }
}
