import 'package:basic_utils/basic_utils.dart';
import 'package:dart_wormhole_gui/views/widgets/GradientBorder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DTButtonLinearGradientWithIcon extends StatelessWidget {
  String label = '';
  Function? handleSelectFile;
  Widget? icon;
  double? width;
  double? height;
  bool? isVertical;
  bool isCodeGenerating = false;

  DTButtonLinearGradientWithIcon({
    String label = '', Function? handleSelectFile,
    Widget? icon, double? height,
    double? width, bool? isVertical,
    bool isCodeGenerating = false,
    Key? key}):super(key:key) {
    this.label = label;
    this.isVertical = isVertical;
    this.handleSelectFile = handleSelectFile;
    this.icon = icon;
    this.isCodeGenerating = isCodeGenerating;
    this.height = height;
    this.width = width;
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration getBorder () {
      return  BoxDecoration(
          border: GradientBorder.uniform(
              width: 3.0,
              gradient: LinearGradient(
                  colors: <Color>[Colors.deepOrange, Colors.grey],
                  stops: [0.3, 0.5]
            )
          ),
        borderRadius:  BorderRadius.all(Radius.circular(1.0)),
      );

    }
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 30.0),
       decoration:  BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(10.0)),
         border: Border(
           top: BorderSide(width: 3.0, color:  Color(0x00C24DF8)),
           left: BorderSide(width: 3.0, color:  Color(0x00C24DF8)),
           right: BorderSide(width: 3.0, color:  Color(0x00C24DF8)),
           bottom: BorderSide(width: 3.0, color:  Color(0x00C24DF8)),
         ),
         gradient: LinearGradient(
           begin: Alignment.topCenter,
           end: Alignment.bottomCenter,
           colors: <Color>[
             Theme.of(context).cardColor.withOpacity(0.4),
             Theme.of(context).primaryColor.withOpacity(0.4),
           ], // red to yellow
           tileMode: TileMode.repeated, // repeats the gradient over the canvas
         ),
       ),
      child: Container(
        decoration: getBorder(),
        width: width,
        height: height,
        child:  FlatButton(
            onPressed: () {
              if(handleSelectFile != null) {
                this.handleSelectFile!();
              }
            },
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Container(
              child: isCodeGenerating ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      Text(
                          label,
                          textAlign: TextAlign.center,
                          style:Theme.of(context).textTheme.headline2
                      ),
                      SizedBox(
                        width: 15.0.w
                      ),
                      SizedBox(
                        width: 25.0.w,
                        height: 25.0.h,
                        child: icon,
                      ),
                  ],
              ): Container(),
            )
        ),
      ),
    );
  }
}

