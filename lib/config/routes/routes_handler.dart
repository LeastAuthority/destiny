import 'dart:io';
import 'package:dart_wormhole_gui/config/routes/routes_desktop_config.dart';
import 'package:dart_wormhole_gui/config/routes/routes_mobile_config.dart';
import 'package:flutter/cupertino.dart';
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  if(Platform.isAndroid) {
    return getMobileRoutes(settings);
  }
  return getDesktopRoutes(settings);
}