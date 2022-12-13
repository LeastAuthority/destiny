import 'package:destiny/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/colors.dart';
import '../../../constants/asset_path.dart';
import '../../../main.dart';
import '../../../settings.dart';
import '../../widgets/Heading.dart';

class DTInfo extends StatelessWidget {
  final String? path;
  final String version;

  DTInfo({
    Key? key,
    required this.path,
    required this.version,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appSettings = getIt<AppSettings>();

    var dataStyle = Theme.of(context).textTheme.headline6;
    var titleStyle = TextStyle(
      fontFamily: MONTSERRAT,
      fontSize: dataStyle?.fontSize,
      color: dataStyle?.color,
    );

    return Container(
        margin: EdgeInsets.only(top: 16.0),
        padding: EdgeInsets.all(16.0),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 3,
          maxWidth: 900,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 2.0, color: CustomColors.purple),
        ),
        child: SingleChildScrollView(
            child: Column(
                key: Key(SETTINGS_SCREEN_CONTENT),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Column(
                children: [
                  Heading(
                    title: CURRENT_SAVE_DESTINATION,
                    textAlign: TextAlign.left,
                    marginTop: 10.0.h,
                    textStyle: titleStyle,
                  ),
                  Heading(
                    textAlign: TextAlign.left,
                    title: path,
                    textStyle: dataStyle,
                    key: Key(SETTINGS_SCREEN_HEADING),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(height: 1.0, color: Colors.white),
                  Heading(
                    title: VERSION,
                    textAlign: TextAlign.left,
                    marginTop: 10.0.h,
                    textStyle: titleStyle,
                  ),
                  Heading(
                    textAlign: TextAlign.left,
                    marginTop: 5.0,
                    title: version,
                    textStyle: dataStyle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(height: 1.0, color: Colors.white),
                  Heading(
                    title: ENV_SETTINGS,
                    textAlign: TextAlign.left,
                    marginTop: 10.0.h,
                    textStyle: titleStyle,
                  ),
                  Heading(
                      title:
                          '$MAILBOX_URL ${appSettings.mailboxUrl.getValue()}',
                      textAlign: TextAlign.left,
                      marginTop: 10.0.h,
                      textStyle: dataStyle),
                  Heading(
                      title:
                          '$TRANSIT_RELAY ${appSettings.transitRelayUrl.getValue()}',
                      textAlign: TextAlign.left,
                      marginTop: 10.0.h,
                      textStyle: dataStyle),
                  Heading(
                      title: '$APP_ID ${appSettings.appId}',
                      textAlign: TextAlign.left,
                      marginTop: 10.0.h,
                      textStyle: dataStyle),
                  SizedBox(
                    height: 132.0,
                  ),
                ],
              ),
            ])));
  }
}
