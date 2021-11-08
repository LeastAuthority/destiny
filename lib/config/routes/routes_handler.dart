import 'dart:io';
import 'package:dart_wormhole_gui/config/routes/routes_desktop_config.dart';
import 'package:dart_wormhole_gui/config/routes/routes_mobile_config.dart';
import 'package:dart_wormhole_gui/config/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Widget onGenerateRoute() {
  if(Platform.isAndroid) {
    return ScreenUtilInit(
      designSize: Size(375,590),
      builder: ()=>  MaterialApp(
        theme: CustomTheme.darkThemeMobile,
        onGenerateRoute: getMobileRoutes,
      )
    );
  }

  return ScreenUtilInit(
      designSize: Size(1280,800),
      builder: ()=>  MaterialApp(
        theme: CustomTheme.darkThemeDesktop,
        onGenerateRoute: getDesktopRoutes,
      )
  );
}