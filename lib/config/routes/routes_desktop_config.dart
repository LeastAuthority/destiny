import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/views/desktop/receive/receive.dart';
import 'package:dart_wormhole_gui/views/desktop/send/send.dart';
import 'package:dart_wormhole_gui/views/desktop/settings.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/cupertino.dart';

import '../../views/desktop/introduction-slider.dart';
import '../../views/desktop/splash.dart';

PageRouteBuilder? Function(RouteSettings) getDesktopRoutes(Config config) {
  return (RouteSettings settings) {
    switch (settings.name) {
      case SPLASH_ROUTE:
        {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => Splash());
        }
      case INTRO_ROUTE:
        {
          return PageRouteBuilder(
              pageBuilder: (_, __, ___) => IntroScreen(config));
        }
      case DESKTOP_SEND_ROUTE:
        {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => SendScreen());
        }
      case RECEIVE_ROUTE:
        {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => ReceiveScreen());
        }
      case SETTINGS_ROUTE:
        {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => Settings());
        }
    }
    return null;
  };
}
