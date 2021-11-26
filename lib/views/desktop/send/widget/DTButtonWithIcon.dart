import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DTButtonWithIcon extends StatelessWidget {
  String? label;
  Function? handleSelectFile;
  Widget? icon;
  double? width;
  double? height;
  bool? isVertical;
  DTButtonWithIcon({
    String? label, Function? handleSelectFile,
    Widget? icon, double? height,
    double? width, bool? isVertical,
    Key? key}):super(key:key) {

    this.label = label;
    this.isVertical = isVertical;
    this.handleSelectFile = handleSelectFile;
    this.icon = icon;
    this.height = height;
    this.width = width;
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration getBorder () {
      var BORDER_COLOR = this.isVertical!?
       Theme.of(context).colorScheme.secondary :
        Theme.of(context).primaryColor;

      var BACKGEOUND_COLOR = this.isVertical!?
       Theme.of(context).colorScheme.secondary :
         Theme.of(context).primaryColor;

      return  BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: BACKGEOUND_COLOR,
        border: Border(
          top: BorderSide(width: 1.0, color: BORDER_COLOR),
          left: BorderSide(width: 1.0, color: BORDER_COLOR),
          right: BorderSide(width: 1.0, color: BORDER_COLOR),
          bottom: BorderSide(width: 1.0, color: BORDER_COLOR),
        ),
      );
    }
    return Container(
      decoration: getBorder(),
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 30.0),
      child: ElevatedButton(
          onPressed: () {
            if(handleSelectFile != null) {
              this.handleSelectFile!();
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).scaffoldBackgroundColor,
            minimumSize: Size.zero,
            maximumSize: Size.zero,
            padding: EdgeInsets.zero,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 35,
                height: 35,
                child: icon,
              ),
              Text(
                  '${label}',
                  style: Theme.of(context).textTheme.subtitle2
              ),
            ],
          )
      )
    );
  }
}
