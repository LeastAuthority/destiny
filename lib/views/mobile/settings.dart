import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/ButtonWithBackground.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/shared/settings.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Settings extends SettingsState {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends SettingsShared<Settings> {
  _SettingsState() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: SETTINGS,
          key: Key(CUSTOM_NAV_BAR),
        ),
        body: Container(
          width: double.infinity,
          key: Key(SETTINGS_SCREEN_BODY),
          padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, bottom: 50.0.h),
          child: Column(
              key: Key(SETTINGS_SCREEN_CONTENT),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Heading(
                      title: '$SELECT_DEFAULT_SAVE_DESTINATION_FOR_THIS_DEVICE '
                          '$CURRENT_SAVE_DESTINATION ',
                      textAlign: TextAlign.left,
                      marginTop: 0,
                      path: path,
                      textStyle: Theme.of(context).textTheme.headline6,
                      key: Key(SETTINGS_SCREEN_HEADING),
                    ),
                  ],
                ),
                ButtonWithBackground(
                    fontSize: 20.0.sp,
                    title: SELECT_A_FOLDER,
                    handleClicked: handleSelectFile,
                    height: 60.0.h,
                    width: 200.0.w,
                    key: Key(SETTINGS_SCREEN_SELECT_A_FOLDER_BUTTON)),
                Button(
                  title: BACK,
                  handleClicked: () {
                    Navigator.pop(context);
                  },
                  disabled: false,
                ),
                Text("version: $version")
              ]),
        ));
  }
}
