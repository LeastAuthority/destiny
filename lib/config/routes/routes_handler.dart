import 'dart:io';
import 'package:dart_wormhole_gui/config/routes/routes_desktop_config.dart';
import 'package:dart_wormhole_gui/config/routes/routes_mobile_config.dart';
import 'package:dart_wormhole_gui/config/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
Widget onGenerateRoute() {
  if(Platform.isAndroid) {
   return MaterialApp(
           theme: CustomTheme.darkThemeMobile,
           onGenerateRoute: getMobileRoutes,
      );
  }
  return MaterialApp(
    theme: CustomTheme.darkThemeDesktop,
    onGenerateRoute: getDesktopRoutes,
  );
}