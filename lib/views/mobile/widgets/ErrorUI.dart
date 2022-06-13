import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/asset_path.dart';
import '../../widgets/Heading.dart';
import 'buttons/ButtonWithBackground.dart';

class ErrorUI extends StatelessWidget {
  final String? errorTitle;
  final String? error;
  final String? errorMessage;
  final String actionText;
  final void Function() onPressed;

  ErrorUI(
      {this.errorTitle,
      this.error,
      this.errorMessage,
      this.actionText = "",
      required this.onPressed,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Heading(
          title: this.errorTitle,
          textStyle: TextStyle(
            fontSize: 14.0,
            fontFamily: MONTSERRAT,
            color: Theme.of(context).colorScheme.secondary,
          ),
          textAlign: TextAlign.left,
        ),
        Heading(
          title: this.error,
          textStyle: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.left,
        ),
        Heading(
          marginTop: 44.0,
          title: errorMessage ?? "Unknown error",
          textStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.headline6?.fontSize,
            fontFamily: MONTSERRAT_LIGHT_ITALIC,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        ButtonWithBackground(
            width: 200.0.w,
            height: 60.0.h,
            title: actionText,
            handleClicked: () {
              onPressed();
            },
            fontSize: 18.0.sp),
      ],
    );
  }
}
