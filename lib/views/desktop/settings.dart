import 'package:destiny/config/routes/routes.dart';
import 'package:destiny/config/theme/colors.dart';
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/views/desktop/widgets/DTButtonWithBackground.dart';
import 'package:destiny/views/desktop/widgets/custom-app-bar.dart';
import 'package:destiny/views/shared/settings.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:destiny/views/widgets/Linkes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/asset_path.dart';

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
                            Container(
                                margin: EdgeInsets.fromLTRB(
                                    100.0, 16.0, 100.0, 100.0),
                                padding: EdgeInsets.all(16.0),
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height / 3,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).dialogBackgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  border: Border.all(
                                      width: 2.0, color: CustomColors.purple),
                                ),
                                child: SingleChildScrollView(
                                    child: Column(
                                        key: Key(SETTINGS_SCREEN_CONTENT),
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                      Column(
                                        children: [
                                          Heading(
                                            title: CURRENT_SAVE_DESTINATION,
                                            textAlign: TextAlign.left,
                                            marginTop: 10.0.h,
                                            textStyle: TextStyle(
                                              fontFamily: MONTSERRAT,
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.fontSize,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.color,
                                            ),
                                          ),
                                          Heading(
                                            textAlign: TextAlign.left,
                                            title: path,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                            key: Key(SETTINGS_SCREEN_HEADING),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Divider(
                                              height: 1.0, color: Colors.white),
                                          Heading(
                                            title: VERSION,
                                            textAlign: TextAlign.left,
                                            marginTop: 10.0.h,
                                            textStyle: TextStyle(
                                              fontFamily: MONTSERRAT,
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.fontSize,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.color,
                                            ),
                                          ),
                                          Heading(
                                            textAlign: TextAlign.left,
                                            marginTop: 5.0,
                                            title: version,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Divider(
                                              height: 1.0, color: Colors.white),
                                          Heading(
                                            title: ENV_SETTINGS,
                                            textAlign: TextAlign.left,
                                            marginTop: 10.0.h,
                                            textStyle: TextStyle(
                                              fontFamily: MONTSERRAT,
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.fontSize,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.color,
                                            ),
                                          ),
                                          Heading(
                                              title:
                                                  '$MAILBOX_URL ${leastAuthority.rendezvousUrl}',
                                              textAlign: TextAlign.left,
                                              marginTop: 10.0.h,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                          Heading(
                                              title:
                                                  '$TRANSIT_RELAY ${leastAuthority.transitRelayUrl}',
                                              textAlign: TextAlign.left,
                                              marginTop: 10.0.h,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                          Heading(
                                              title:
                                                  '$APP_ID ${leastAuthority.appId}',
                                              textAlign: TextAlign.left,
                                              marginTop: 10.0.h,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                          SizedBox(
                                            height: 132.0,
                                          ),
                                        ],
                                      ),
                                    ])))
                          ],
                        ),
                      ],
                    )),
              ),
            )));
  }
}
