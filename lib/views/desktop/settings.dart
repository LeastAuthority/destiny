import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            path: SETTINGS_ROUTE,
            key:Key(CUSTOM_NAV_BAR),
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Container (
              width: double.infinity,
              padding: EdgeInsets.only(left: 125.0.w, right: 125.0.w),
              child: Container(
                  margin: EdgeInsets.fromLTRB(16.0.w, 30.0.h, 16.0.w, 22.0.h),
                  decoration: BoxDecoration (
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: Border(
                      top: BorderSide(width: 2.0, color: CustomColors.purple),
                      left: BorderSide(width: 2.0, color: CustomColors.purple),
                      right: BorderSide(width: 2.0, color:  CustomColors.purple),
                      bottom: BorderSide(width: 2.0, color: CustomColors.purple),
                    ),
                  ),
                  width: double.infinity,
                  key: Key(SEND_SCREEN_BODY),
                  padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
                  child: Container (
                    height:  double.infinity,
                    margin: EdgeInsets.fromLTRB(16.0.w, 0.0, 16.0.w, 4.0.w),
                    child: Column (
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                        ],
                    )
                  ),
              ),
          )
        )
    );
  }
}
