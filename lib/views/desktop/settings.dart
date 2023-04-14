import 'dart:io';

import 'package:destiny/config/routes/routes.dart';
import 'package:destiny/config/theme/colors.dart';
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/views/desktop/widgets/DTButtonWithBackground.dart';
import 'package:destiny/views/desktop/widgets/DTInfo.dart';
import 'package:destiny/views/desktop/widgets/custom-app-bar.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:destiny/views/widgets/Links.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../main.dart';
import '../../settings.dart';
import '../../version.dart';
import '../shared/util.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() {
    final appSettings = getIt<AppSettings>();
    return _SettingsState(appSettings.folder);
  }
}

class _SettingsState extends State<Settings> {
  final Preference<String> folder;
  bool selectingFolder = false;

  _SettingsState(this.folder);

  @override
  Widget build(BuildContext context) {
    final version = getIt<Version>();
    return Scaffold(
        appBar: CustomAppBar(
          path: SETTINGS_ROUTE,
          key: Key(CUSTOM_NAV_BAR),
        ),
        body: WillPopScope(
            onWillPop: onWillPopHandler,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 125.0.w, right: 125.0.w),
              child: Container(
                margin: EdgeInsets.fromLTRB(16.0.w, 30.0.h, 16.0.w, 16.0.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: Border.all(width: 2.0, color: CustomColors.purple)),
                width: double.infinity,
                key: Key(SEND_SCREEN_BODY),
                child: Container(
                    height: double.infinity,
                    color: Theme.of(context).dialogBackgroundColor,
                    padding:
                        EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25.0, bottom: 25.0),
                          child: Links(
                            fontSize: 17.0,
                          ),
                        ),
                        Heading(
                          title:
                              SELECT_DEFAULT_SAVE_DESTINATION_FOR_THIS_DEVICE,
                          textAlign: TextAlign.center,
                          textStyle: Theme.of(context).textTheme.headline1,
                          // key: Key('Timing_Progress'),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        DTButtonWithBackground(
                          onPressed: selectSaveDestination,
                          title: SELECT_A_FOLDER,
                          width: 150.0,
                          disabled: false,
                        ),
                        DTInfo(
                            path: this.folder.getValue(),
                            version: version.getFullVersion()),
                      ],
                    )),
              ),
            )));
  }

  void selectSaveDestination() async {
    if (selectingFolder) return;
    try {
      this.setState(() {
        selectingFolder = true;
      });
      String? directory = await FilePicker.platform
          .getDirectoryPath(initialDirectory: this.folder.getValue());
      if (directory == null) {
        return;
      }

      if (await canWriteToDirectory(directory)) {
        setState(() {
          this.folder.setValue("$directory${Platform.pathSeparator}");
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              THE_APP_DOES_NOT_HAVE_THE_PREMISSION_TO_STORE_FILES_IN_THE_DIR),
        ));
      }
    } finally {
      this.setState(() {
        selectingFolder = false;
      });
    }
  }
}
