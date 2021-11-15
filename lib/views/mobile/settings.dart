import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/ButtonWithBackground.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:  CustomBottomBar(
             path: SETTINGS_ROUTE,
             key: Key(BOTTOM_NAV_BAR),
        ),
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
                                  '${CURRENT_SAVE_DESTINATION}',
                              textAlign: TextAlign.left,
                              marginTop: 0,
                              path: 'Destiny/Received',
                              textStyle: Theme.of(context).textTheme.bodyText1,
                              key: Key(SETTINGS_SCREEN_HEADING),
                            ),
                          ],
                        ),
                        ButtonWithBackground(
                            handleSelectFolder: (){},
                            key:Key(SETTINGS_SCREEN_SELECT_A_FOLDER_BUTTON)
                        ),
                      Button(BACK, () {
                      })
                    ]
                ),

    ));
  }
}
