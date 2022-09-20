import 'package:destiny/config/routes/routes.dart';
import 'package:destiny/config/theme/colors.dart';
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/views/desktop/widgets/DTButtonWithBackground.dart';
import 'package:destiny/views/desktop/widgets/DTInfo.dart';
import 'package:destiny/views/desktop/widgets/custom-app-bar.dart';
import 'package:destiny/views/shared/settings.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:destiny/views/widgets/Links.dart';
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
          path: SETTINGS_ROUTE,
          key: Key(CUSTOM_NAV_BAR),
        ),
        body: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 125.0.w, right: 125.0.w),
              child: Container(
                margin: EdgeInsets.fromLTRB(16.0.w, 30.0.h, 16.0.w, 22.0.h),
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
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25.0, bottom: 25.0),
                          child: Links(
                            fontSize: 25.0,
                          ),
                        ),
                        Heading(
                          title:
                              SELECT_DEFAULT_SAVE_DESTINATION_FOR_THIS_DEVICE,
                          textAlign: TextAlign.center,
                          textStyle: Theme.of(context).textTheme.headline1,
                          // key: Key('Timing_Progress'),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 16.0,
                            ),
                            DTButtonWithBackground(
                              onPressed: selectSaveDestination,
                              title: SELECT_A_FOLDER,
                              width: 150.0,
                              disabled: false,
                            ),
                            DTInfo(path: path, version: version)
                          ],
                        ),
                      ],
                    )),
              ),
            )));
  }
}
