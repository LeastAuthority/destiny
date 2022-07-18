import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTButtonWithBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/asset_path.dart';
import '../../../../widgets/ExpandableTextBox.dart';
import '../../../widgets/Heading.dart';

void doNothing() {
  print("Doing nothing with error UI button");
}

class DTErrorUI extends StatelessWidget {
  final String? errorTitle;
  final String? error;
  final String? errorMessage;

  final String buttonTitle;
  final double paddingTop;
  final void Function() onPressed;
  final bool? showBoxDecoration;

  DTErrorUI(
      {this.errorTitle = '',
      this.error = '',
      this.errorMessage = '',
      this.showBoxDecoration = false,
      this.onPressed = doNothing,
      this.buttonTitle = '',
      this.paddingTop = 0.0,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: showBoxDecoration == true
            ? BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(width: 2.0, color: CustomColors.purple),
              )
            : null,
        padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, top: paddingTop),
        child: Column(children: [
          Heading(
            title: errorTitle,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
                fontFamily: MONTSERRAT_MEDIUM,
                fontSize: Theme.of(context).textTheme.headline1?.fontSize,
                color: Theme.of(context).textTheme.headline1?.color),
          ),
          Heading(
              marginTop: 20,
              title: error,
              isVisible: error != '',
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                fontSize: 20.0.sp,
                fontFamily: Theme.of(context).textTheme.headline1?.fontFamily,
                color: Theme.of(context).textTheme.headline1?.color,
              )),
          ExtensiveDesktopErrorExpandable(
            error: this.error,
            errorMessage: this.errorMessage,
          ),
          SizedBox(
            height: this.error != '' ? 100.0.h : 16.0.h,
          ),
          DTButtonWithBackground(
            onPressed: onPressed,
            title: buttonTitle,
            width: 150.0,
            disabled: false,
          )
        ]));
  }
}

class ExtensiveDesktopErrorExpandable extends StatelessWidget {
  final String? error;
  final String? errorMessage;
  ExtensiveDesktopErrorExpandable({
    Key? key,
    required this.error,
    required this.errorMessage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (error == '')
      return Column(
        children: [
          SizedBox(
            height: 30.0.h,
          ),
          Heading(
            title: 'See details',
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
              fontFamily: COURIER,
            ),
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                  flex: 10,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                    child: ExpandableTextBox(
                      showBorders: true,
                      errorMessage: errorMessage,
                      height: MediaQuery.of(context).size.height - 530.0.h,
                      fontSize: 17.0,
                    ),
                  )),
              Expanded(flex: 1, child: Container()),
            ],
          )
        ],
      );

    return Container();
  }
}
