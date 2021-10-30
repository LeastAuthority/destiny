import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatefulWidget {
  final String title;
  Function handleSelectFile;
  Button(this.title, this.handleSelectFile);

  @override
  _CustomAppBarState createState() => _CustomAppBarState(title, handleSelectFile);
}

class _CustomAppBarState extends State<Button> {
  final String title;
  Function handleSelectFile;
  Widget? icon;
  _CustomAppBarState(this.title, this.handleSelectFile);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

