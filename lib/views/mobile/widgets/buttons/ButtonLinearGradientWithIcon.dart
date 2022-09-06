import 'package:destiny/config/theme/colors.dart';
import 'package:destiny/views/widgets/GradientBorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLinearGradientWithIcon extends StatelessWidget {
  final String label;
  final Function? handleSelectFile;
  final Widget? icon;
  final double? width;
  final double? height;
  final bool? isVertical;
  final bool isCodeGenerating;

  ButtonLinearGradientWithIcon(
      {required this.label,
      this.handleSelectFile,
      this.icon,
      this.height,
      this.width,
      this.isVertical,
      required this.isCodeGenerating,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration getBorder() {
      return BoxDecoration(
        border: GradientBorder.uniform(
            width: 3.0,
            gradient: LinearGradient(
                colors: <Color>[Colors.deepOrange, Colors.grey],
                stops: [0.3, 0.5])),
        borderRadius: BorderRadius.all(Radius.circular(1.0)),
      );
    }

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(width: 3.0, color: Color(0x00C24DF8)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          colors: <Color>[
            Theme.of(context).primaryColor,
            CustomColors.lightBlue
          ], // red to yellow
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      child: Container(
        decoration: getBorder(),
        width: width,
        height: height,
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor),
            onPressed: () {
              if (handleSelectFile != null) {
                this.handleSelectFile!();
              }
            },
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 11,
                    child: Text(label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5),
                  ),
                  isCodeGenerating
                      ? Expanded(
                          flex: 2,
                          child: SizedBox(
                            // width: 25.0.w,
                            height: 25.0.h,
                            child: icon,
                          ),
                        )
                      : Container()
                ],
              ),
            )),
      ),
    );
  }
}
