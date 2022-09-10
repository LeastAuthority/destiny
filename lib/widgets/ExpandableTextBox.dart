import 'dart:io';

import 'package:destiny/views/widgets/Heading.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_constants.dart';
import '../constants/asset_path.dart';
import '../views/desktop/widgets/DTButton.dart';
import '../widgets/buttons/Button.dart';

class ExpandableTextBox extends StatelessWidget {
  final String? error;
  final String? errorMessage;
  final bool? showBorders;
  final double? height;
  final double? fontSize;
  final Color? bgColor;

  ExpandableTextBox({
    Key? key,
    this.error = '',
    this.errorMessage = '',
    this.showBorders = false,
    this.height,
    this.fontSize,
    this.bgColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isAndroid = Platform.isAndroid;
    return ExpandChild(
        showBorders: showBorders,
        expandedBGColor: bgColor,
        arrowColor: Theme.of(context).primaryColor,
        arrowSize: 40.0,
        child: Container(
            padding: EdgeInsets.all(16.0),
            child: Container(
                height: height,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Heading(
                        title: errorMessage ?? errorMessage.toString(),
                        textStyle: TextStyle(
                          color: Theme.of(context).textTheme.headline1?.color,
                          fontSize: fontSize,
                          fontFamily: COURIER,
                        ),
                        textAlign: TextAlign.left),
                    SizedBox(
                      height: isAndroid ? 0.0 : 32,
                    ),
                    isAndroid
                        ? Button(COPY, () {
                            Clipboard.setData(ClipboardData(
                                text: errorMessage ?? errorMessage.toString()));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(CODE_COPIED),
                            ));
                          }, false, 20.0.h, 60.0.w,
                            Theme.of(context).bottomAppBarTheme.color)
                        : DTButton(COPY, () {
                            Clipboard.setData(ClipboardData(
                                text: errorMessage ?? errorMessage.toString()));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(CODE_COPIED),
                            ));
                          }, Theme.of(context).bottomAppBarTheme.color)
                  ],
                )))));
  }
}
