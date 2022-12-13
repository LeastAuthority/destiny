import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/constants/asset_path.dart';
import 'package:destiny/settings.dart';
import 'package:destiny/views/mobile/widgets/PreferenceEditor.dart';
import 'package:destiny/views/mobile/widgets/buttons/Button.dart';
import 'package:destiny/views/mobile/widgets/custom-app-bar.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';
import '../../version.dart';
import '../widgets/Links.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() {
    final appSettings = getIt<AppSettings>();
    final version = getIt<Version>();
    return _InfoState(appSettings, version);
  }
}

class _InfoState extends State<Info> {
  final AppSettings appSettings;
  late String folderValue;
  final Version version;

  _InfoState(this.appSettings, this.version)
      : this.folderValue = appSettings.folder.getValue();

  @override
  Widget build(BuildContext context) {
    final headingStyle = TextStyle(
      fontFamily: MONTSERRAT,
      fontSize: Theme.of(context).textTheme.headline6?.fontSize,
      color: Theme.of(context).textTheme.headline6?.color,
    );

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
                      Links(fontSize: 16.0),
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
                        path: this.folderValue,
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
                        path: version.getFullVersion(),
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
                        textStyle: headingStyle,
                      ),
                      PopupEditText(
                        appSettings.mailboxUrl,
                        title: TRANSIT_RELAY,
                        marginTop: 5.0,
                      ),
                      Heading(
                        title: TRANSIT_RELAY,
                        textAlign: TextAlign.left,
                        marginTop: 10.0.h,
                        textStyle: headingStyle,
                      ),
                      PopupEditText(
                        appSettings.transitRelayUrl,
                        title: TRANSIT_RELAY,
                        marginTop: 5.0,
                      ),
                      Heading(
                        title: APP_ID,
                        textAlign: TextAlign.left,
                        marginTop: 10.0.h,
                        textStyle: headingStyle,
                      ),
                      PopupEditText(appSettings.appId, marginTop: 5.0),
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
