import 'package:destiny/config/theme/colors.dart';
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/constants/asset_path.dart';
import 'package:destiny/views/mobile/widgets/buttons/Button.dart';
import 'package:destiny/views/mobile/widgets/custom-app-bar.dart';
import 'package:destiny/views/shared/settings.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class Info extends SettingsState {
  Info({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends SettingsShared<Info> {
  _SettingsState() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: INFO,
          key: Key(CUSTOM_NAV_BAR),
        ),
        body: Container(
            width: double.infinity,
            key: Key(SETTINGS_SCREEN_BODY),
            padding:
                EdgeInsets.only(left: 16.0.w, right: 16.0.w, bottom: 50.0.h),
            child: SingleChildScrollView(
                child: Column(
                    key: Key(SETTINGS_SCREEN_CONTENT),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            child: Text(FEEDBACK,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: CustomColors.lighterBlue,
                                  fontSize: 16.0,
                                )),
                            onTap: () async {
                              const url = FEEDBACK_LINK;
                              launch(url);
                            },
                          ),
                          SizedBox(
                            width: 24.0,
                          ),
                          GestureDetector(
                            child: Text(FQA,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: CustomColors.lighterBlue,
                                    fontSize: 16.0)),
                            onTap: () async {
                              const url = FQA_LINK;
                              launch(url);
                            },
                          ),
                          SizedBox(
                            width: 24.0,
                          ),
                          GestureDetector(
                            child: Text(PRIVACY,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: CustomColors.lighterBlue,
                                    fontSize: 16.0)),
                            onTap: () async {
                              const url = PRIVACY_LINK;
                              launch(url);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(height: 1.0, color: Colors.white),
                      Heading(
                        title: DEFAULT_SAVE_DESTINATION,
                        textAlign: TextAlign.left,
                        marginTop: 10.0.h,
                        textStyle: Theme.of(context).textTheme.headline6,
                      ),
                      Heading(
                        textAlign: TextAlign.left,
                        marginTop: 5.0,
                        path: path,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(height: 1.0, color: Colors.white),
                      Heading(
                        title: VERSION,
                        textAlign: TextAlign.left,
                        marginTop: 10.0.h,
                        textStyle: Theme.of(context).textTheme.headline6,
                      ),
                      Heading(
                        textAlign: TextAlign.left,
                        marginTop: 5.0,
                        path: version,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(height: 1.0, color: Colors.white),
                      Heading(
                        title: ENV_SETTINGS,
                        textAlign: TextAlign.left,
                        marginTop: 10.0.h,
                        textStyle: Theme.of(context).textTheme.headline6,
                      ),
                      Heading(
                        title: MAILBOX_URL,
                        textAlign: TextAlign.left,
                        marginTop: 10.0.h,
                        textStyle: TextStyle(
                          fontFamily: MONTSERRAT,
                          fontSize:
                              Theme.of(context).textTheme.headline6?.fontSize,
                          color: Theme.of(context).textTheme.headline6?.color,
                        ),
                      ),
                      Heading(
                        textAlign: TextAlign.left,
                        marginTop: 5.0,
                        path: leastAuthority.rendezvousUrl,
                      ),
                      Heading(
                        title: TRANSIT_RELAY,
                        textAlign: TextAlign.left,
                        marginTop: 10.0.h,
                        textStyle: TextStyle(
                          fontFamily: MONTSERRAT,
                          fontSize:
                              Theme.of(context).textTheme.headline6?.fontSize,
                          color: Theme.of(context).textTheme.headline6?.color,
                        ),
                      ),
                      Heading(
                        textAlign: TextAlign.left,
                        marginTop: 5.0,
                        path: leastAuthority.transitRelayUrl,
                      ),
                      Heading(
                        title: APP_ID,
                        textAlign: TextAlign.left,
                        marginTop: 10.0.h,
                        textStyle: TextStyle(
                          fontFamily: MONTSERRAT,
                          fontSize:
                              Theme.of(context).textTheme.headline6?.fontSize,
                          color: Theme.of(context).textTheme.headline6?.color,
                        ),
                      ),
                      Heading(
                        textAlign: TextAlign.left,
                        marginTop: 5.0,
                        path: leastAuthority.appId,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(height: 1.0, color: Colors.white),
                    ],
                  ),
                  Button(
                    title: BACK,
                    handleClicked: () {
                      Navigator.pop(context);
                    },
                    disabled: false,
                  ),
                ]))));
  }
}
