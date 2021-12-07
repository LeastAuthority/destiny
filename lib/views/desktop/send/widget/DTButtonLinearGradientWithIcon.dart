import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DTButtonLinearGradientWithIcon extends StatelessWidget {
  String label = '';
  Function? handleSelectFile;
  Widget? icon;
  double? width;
  double? height;
  bool isCodeGenerating = false;

  DTButtonLinearGradientWithIcon(
      {required String label,
      Function? handleSelectFile,
      Widget? icon,
      double? height,
      double? width,
      bool isCodeGenerating = false,
      Key? key})
      : super(key: key) {
    this.label = label;
    this.handleSelectFile = handleSelectFile;
    this.icon = icon;
    this.isCodeGenerating = isCodeGenerating;
    this.height = height;
    this.width = width;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: !isCodeGenerating
            ? Border(
                top: BorderSide(
                    width: 1.0, color: Theme.of(context).primaryColor),
                left: BorderSide(
                    width: 1.0, color: Theme.of(context).primaryColor),
                right: BorderSide(
                    width: 1.0, color: Theme.of(context).primaryColor),
                bottom: BorderSide(
                    width: 1.0, color: Theme.of(context).primaryColor),
              )
            : Border(
                top: BorderSide(width: 3.0, color: Color(0x00C24DF8)),
                left: BorderSide(width: 3.0, color: Color(0x00C24DF8)),
                right: BorderSide(width: 3.0, color: Color(0x00C24DF8)),
                bottom: BorderSide(width: 3.0, color: Color(0x00C24DF8)),
              ),
        gradient: isCodeGenerating
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Theme.of(context).cardColor.withOpacity(0.4),
                  Theme.of(context).primaryColor.withOpacity(0.4),
                ], // red to yellow
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              )
            : null,
      ),
      child: Container(
        width: width,
        height: height,
        child: FlatButton(
            onPressed: () {
              if (handleSelectFile != null) {
                this.handleSelectFile!();
              }
            },
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Container(
              child: isCodeGenerating
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(label,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2),
                        SizedBox(width: 15.0.w),
                        SizedBox(
                          width: 25.0.w,
                          height: 25.0.h,
                          child: icon,
                        ),
                      ],
                    )
                  : Container(
                      child: Text(label,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2),
                    ),
            )),
      ),
    );
  }
}
