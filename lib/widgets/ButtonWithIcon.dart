import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWithIcon extends StatefulWidget {
  final String title;
  Function handleSelectFile;
  Widget icon;
  ButtonWithIcon(this.title, this.handleSelectFile, this.icon);

  @override
  _CustomAppBarState createState() => _CustomAppBarState(title, handleSelectFile, icon);
}

class _CustomAppBarState extends State<ButtonWithIcon> {
  final String title;
  Function handleSelectFile;
  Widget? icon;
  _CustomAppBarState(this.title, this.handleSelectFile, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border(
          top: BorderSide(width: 1.0, color: Color(0xffC24DF8)),
          left: BorderSide(width: 1.0, color: Color(0xffC24DF8)),
          right: BorderSide(width: 1.0, color: Color(0xffC24DF8)),
          bottom: BorderSide(width: 1.0, color: Color(0xffC24DF8)),
        ),
      ),
      width: 190.0.w,
      height: 70.0.w,
      margin: const EdgeInsets.only(top: 30.0),
      child:  FlatButton(
        onPressed: () => handleSelectFile(),
        color: Color(0x00353846),
        child: Row( // Replace with a Row for horizontal icon + text
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0.w),
              child: Text('${title}', style:TextStyle(color: Colors.white, fontSize: 14.sp)),
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
}

