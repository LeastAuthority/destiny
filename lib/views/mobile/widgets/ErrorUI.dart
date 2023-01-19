import 'dart:io' as dartIO;
import 'package:destiny/views/widgets/Heading.dart';
import 'package:destiny/widgets/ExpandableTextBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/asset_path.dart';
import 'buttons/ButtonWithBackground.dart';

class ErrorUI extends StatelessWidget {
  final String? errorTitle;
  final String? error;
  final String? errorMessage;
  final String actionText;
  final String actionMedia;
  final void Function() onPressed, onPressedMedia;

  ErrorUI(
      {this.errorTitle = "",
      this.error = "",
      this.errorMessage = "",
      this.actionText = "",
      this.actionMedia = "",
      required this.onPressed,
      required this.onPressedMedia,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        children: [
          Heading(
            title: errorTitle ?? errorTitle.toString(),
            textAlign: TextAlign.center,
            textStyle: Theme.of(context).textTheme.subtitle1,
          ),
          Heading(
              marginTop: 20,
              title: error ?? error.toString(),
              textAlign: TextAlign.center,
              isVisible: error != '',
              textStyle: TextStyle(
                fontSize: 14.0.sp,
                fontFamily: Theme.of(context).textTheme.subtitle2?.fontFamily,
                color: Theme.of(context).textTheme.subtitle2?.color,
              )),
          SizedBox(height: 10.0),
          ExtensiveMobileErrorExpandable(
            error: this.error,
            errorMessage: this.errorMessage,
          ),
        ],
      ),
      Container(
          margin: EdgeInsets.only(bottom: 70.0.h),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWithBackground(
                    width: 200.0.w,
                    height: 60.0.h,
                    title: actionText,
                    handleClicked: () {
                      onPressed();
                    },
                    fontSize: 18.0.sp),
                // Visible only for Android, as iOS is not supported by file_picker
                // Disable second button show on Receive windows, as we need only one button to go back
                if (dartIO.Platform.isIOS && actionText != RECEIVE_A_FILE)
                  ButtonWithBackground(
                      width: 200.0.w,
                      height: 60.0.h,
                      title: actionMedia,
                      handleClicked: () {
                        onPressedMedia();
                      },
                      fontSize: 18.0.sp)
              ]))
    ]);
  }
}

class ExtensiveMobileErrorExpandable extends StatelessWidget {
  final String? error;
  final String? errorMessage;
  ExtensiveMobileErrorExpandable({
    Key? key,
    required this.error,
    required this.errorMessage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (error == '')
      return Column(
        children: [
          Heading(
            title: SEE_DETAILS,
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
              fontFamily: MONTSERRAT_THIN,
            ),
          ),
          SizedBox(height: 4.0),
          ExpandableTextBox(
            bgColor: Theme.of(context).bottomAppBarTheme.color,
            showBorders: false,
            errorMessage: errorMessage,
            fontSize: 12.0,
          )
        ],
      );

    return Container();
  }
}
