import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DTButtonLinearGradientWithIcon extends StatelessWidget {
  final String label;
  final Function? handleSelectFile;
  final Widget? icon;
  final double? width;
  final double? height;
  final bool isCodeGenerating;

  DTButtonLinearGradientWithIcon(
      {required this.label,
      this.handleSelectFile,
      this.icon,
      this.height,
      this.width,
      required this.isCodeGenerating,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: !isCodeGenerating
            ? Border.all(width: 1.0, color: Theme.of(context).primaryColor)
            : Border.all(width: 3.0, color: Theme.of(context).primaryColor),
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
        child: TextButton(
            onPressed: () {
              if (handleSelectFile != null) {
                this.handleSelectFile!();
              }
            },
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor),
            child: Container(
              child: isCodeGenerating
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(label,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2
                        ),
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
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
            )),
      ),
    );
  }
}
