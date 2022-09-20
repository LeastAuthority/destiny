import 'package:destiny/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/colors.dart';
import '../../../constants/asset_path.dart';
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
    return Container(
        margin: EdgeInsets.fromLTRB(100.0, 16.0, 100.0, 100.0),
        padding: EdgeInsets.all(16.0),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 3,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
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
                    textStyle: TextStyle(
                      fontFamily: MONTSERRAT,
                      fontSize: Theme.of(context).textTheme.headline6?.fontSize,
                      color: Theme.of(context).textTheme.headline6?.color,
                    ),
                  ),
                  Heading(
                    textAlign: TextAlign.left,
                    title: path,
                    textStyle: Theme.of(context).textTheme.headline6,
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
                    textStyle: TextStyle(
                      fontFamily: MONTSERRAT,
                      fontSize: Theme.of(context).textTheme.headline6?.fontSize,
                      color: Theme.of(context).textTheme.headline6?.color,
                    ),
                  ),
                  Heading(
                    textAlign: TextAlign.left,
                    marginTop: 5.0,
                    title: version,
                    textStyle: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(height: 1.0, color: Colors.white),
                  Heading(
                    title: ENV_SETTINGS,
                    textAlign: TextAlign.left,
                    marginTop: 10.0.h,
                    textStyle: TextStyle(
                      fontFamily: MONTSERRAT,
                      fontSize: Theme.of(context).textTheme.headline6?.fontSize,
                      color: Theme.of(context).textTheme.headline6?.color,
                    ),
                  ),
                  Heading(
                      title: '$MAILBOX_URL ${leastAuthority.rendezvousUrl}',
                      textAlign: TextAlign.left,
                      marginTop: 10.0.h,
                      textStyle: Theme.of(context).textTheme.headline6),
                  Heading(
                      title: '$TRANSIT_RELAY ${leastAuthority.transitRelayUrl}',
                      textAlign: TextAlign.left,
                      marginTop: 10.0.h,
                      textStyle: Theme.of(context).textTheme.headline6),
                  Heading(
                      title: '$APP_ID ${leastAuthority.appId}',
                      textAlign: TextAlign.left,
                      marginTop: 10.0.h,
                      textStyle: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: 132.0,
                  ),
                ],
              ),
            ])));
  }
}
