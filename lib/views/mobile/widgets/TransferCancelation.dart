import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/ButtonWithBackground.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransferCancelation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        key: Key(SEND_SCREEN_CONTENT),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Heading(
            title: THE_TRANSFER_HAS_BEEN_CANCELLED_BY_THE_RECEIVER,
            textAlign: TextAlign.left,
            marginTop: 0,
            textStyle: Theme.of(context).textTheme.bodyText1,
            key: Key(SEND_SCREEN_HEADING),
          ),
          ButtonWithBackground(
              title: RETURN_TO_SEND_HOME,
              height: 50.0.h,
              width: 205.0.w,
              disabled: false,
              handleClicked: () {},
              key: Key(SEND_SCREEN_SELECT_A_FILE_BUTTON)),
          SizedBox(
            key: Key(SEND_SCREEN_BOTTOM_SPACE_PLACEHOLDER),
            height: 100.h,
          ),
        ]);
  }
}
