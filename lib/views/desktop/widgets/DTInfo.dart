import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/widgets/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/colors.dart';
import '../../../constants/asset_path.dart';
import '../../../main.dart';
import '../../../settings.dart';
import '../../../widgets/prefs_edit.dart';
import '../../mobile/Info.dart';
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
    var titleStyle = dataStyle?.copyWith(fontFamily: MONTSERRAT);

    const editButtonWidth = 80.0;
    return Container(
        margin: EdgeInsets.only(top: 16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 2.0, color: CustomColors.purple),
        ),
        child: Column(
            key: Key(SETTINGS_SCREEN_CONTENT),
            crossAxisAlignment: CrossAxisAlignment.center,
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
              EditableStringPrefs(
                appSettings.mailboxUrl,
                title: MAILBOX_URL,
                validator: uriStringValidator,
                marginTop: 5.0,
                editButtonWidth: editButtonWidth,
              ),
              EditableStringPrefs(
                appSettings.transitRelayUrl,
                expandDefaults: expandTransitRelayDefaultValues,
                title: TRANSIT_RELAY,
                validator: uriStringValidator,
                marginTop: 5.0,
                editButtonWidth: editButtonWidth,
              ),
              EditableStringPrefs(
                appSettings.appId,
                title: APP_ID,
                validator: stringValidator,
                marginTop: 5.0,
                editButtonWidth: editButtonWidth,
              ),
            ]));
  }
}
