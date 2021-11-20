import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/ButtonWithBackground.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _path = '';
  SharedPreferences? prefs;
  _SettingsState () {
    initializePrefs();
  }
  void initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
  Future storePath(String path) async {
    return prefs?.setString(PATH, path);
  }
  Future<String> getPath () async {
    String prefPath = await prefs?.getString(PATH) ?? '';
    return prefPath;
  }
  void handleSelectFile () async {
    String? result = await FilePicker.platform.getDirectoryPath();
    if(result != null) {
      storePath(result);
      setState(() {
        _path = result;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: SETTINGS,
            key:Key(CUSTOM_NAV_BAR),
        ),
        body: Container(
          width: double.infinity,
          key: Key(SETTINGS_SCREEN_BODY),
          padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, bottom: 50.0.h),
          child: Column(
                    key: Key(SETTINGS_SCREEN_CONTENT),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Column(
                          children: [
                            Heading(
                              title:
                              '${SELECT_DEFAULT_SAVE_DESTINATION_FOR_THIS_DEVICE} '
                                  '${CURRENT_SAVE_DESTINATION} ',
                              textAlign: TextAlign.left,
                              marginTop: 0,
                              path: getPath().toString(),
                              textStyle: Theme.of(context).textTheme.bodyText1,
                              key: Key(SETTINGS_SCREEN_HEADING),
                            ),
                          ],
                        ),
                        ButtonWithBackground(
                            handleSelectFolder: handleSelectFile,
                            key:Key(SETTINGS_SCREEN_SELECT_A_FOLDER_BUTTON)
                        ),
                      Button(
                          title: BACK,
                          handleSelectFile: () {Navigator.pop(context);},
                          disabled: false,
                          opacity: 1.0
                      )
                    ]
                ),

    ));
  }
}
