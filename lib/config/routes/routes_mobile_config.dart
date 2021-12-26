import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/receive.dart';
import 'package:dart_wormhole_gui/views/mobile/send/send.dart';
import 'package:flutter/cupertino.dart';
import 'package:dart_wormhole_gui/views/mobile/introduction-slider.dart';
import 'package:dart_wormhole_gui/views/mobile/settings.dart';
import 'package:dart_wormhole_gui/views/mobile/splash.dart';

PageRouteBuilder? getMobileRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SPLASH_ROUTE:
      {
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Splash());
      }
      break;
    case INTRO_ROUTE:
      {
        return PageRouteBuilder(pageBuilder: (_, __, ___) => IntroScreen());
      }
      break;
    case SEND_ROUTE:
      {
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Send());
      }
      break;
    case RECEIVE_ROUTE:
      {
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Receive());
      }
      break;
    case SETTINGS_ROUTE:
      {
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Settings());
      }
      break;
  }
  return null;
}
