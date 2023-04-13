import 'dart:io' as dartIO;
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/generated/locale_keys.g.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:destiny/views/mobile/widgets/buttons/ButtonWithIcon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:destiny/constants/asset_path.dart';

class SelectAFileUI extends StatelessWidget {
  final Function handleSelectFile;
  final Function handleSelectMedia;

  SelectAFileUI(this.handleSelectFile, this.handleSelectMedia);

  @override
  Widget build(BuildContext context) {
    return Column(
        key: Key(SEND_SCREEN_CONTENT),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Heading(
            title: LocaleKeys.send_topic.tr(),
            textAlign: TextAlign.left,
            marginTop: 0,
            textStyle: Theme.of(context).textTheme.headline6,
            key: Key(SEND_SCREEN_HEADING),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ButtonWithIcon(
                fontSize: Theme.of(context).textTheme.headline2!.fontSize,
                fontFamily: Theme.of(context).textTheme.headline2!.fontFamily,
                label: LocaleKeys.generic_select_file.tr(),
                handleSelectFile: handleSelectFile,
                icon: Image.asset(
                  PHONE_ICON,
                  width: 30.0.w,
                ),
                height: 60.0.h,
                width: 205.0.w,
                isVertical: false,
                key: Key(SEND_SCREEN_SELECT_A_FILE_BUTTON)),
            // Visible only for Android, as iOS is not supported by file_picker

            if (dartIO.Platform.isIOS)
              ButtonWithIcon(
                  fontSize: Theme.of(context).textTheme.headline2!.fontSize,
                  fontFamily: Theme.of(context).textTheme.headline2!.fontFamily,
                  label: SELECT_A_MEDIA,
                  handleSelectFile: handleSelectMedia,
                  icon: Image.asset(
                    PHONE_ICON,
                    width: 30.0.w,
                  ),
                  height: 60.0.h,
                  width: 205.0.w,
                  isVertical: false,
                  key: Key(SEND_SCREEN_SELECT_A_MEDIA_BUTTON))
          ]),
          SizedBox(
            key: Key(SEND_SCREEN_BOTTOM_SPACE_PLACEHOLDER),
            height: 100.h,
          ),
        ]);
  }
}
