import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DTButtonWithBackground extends StatelessWidget {
  final String title;
  final Function handleSelectFile;
  final double width;
  final Widget? icon;
  DTButtonWithBackground({
    required this.title,
    required this.handleSelectFile,
    required this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(width: 1.0, color: CustomColors.purple),
      ),
      width: width,
      height: 30.0.h,
      child: TextButton(
        onPressed: () => handleSelectFile(),
        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor),
        child: Text('$title', style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}
