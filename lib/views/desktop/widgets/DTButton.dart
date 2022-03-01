import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DTButton extends StatefulWidget {
  final String title;
  final Function handleSelectFile;
  DTButton(this.title, this.handleSelectFile);

  @override
  _CustomAppBarState createState() =>
      _CustomAppBarState(title, handleSelectFile);
}

class _CustomAppBarState extends State<DTButton> {
  final String title;
  Function handleSelectFile;
  Widget? icon;
  _CustomAppBarState(this.title, this.handleSelectFile);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(width: 1.0, color: CustomColors.purple),
      ),
      width: 100.0.w,
      height: 30.0.h,
      child: TextButton(
        onPressed: () => handleSelectFile(),
        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        child: Text('$title', style: Theme.of(context).textTheme.headline5),
      ),
    );
  }
}
