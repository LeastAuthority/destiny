import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/views/mobile/introduction-slider.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/receive.dart';
import 'package:dart_wormhole_gui/views/mobile/send/send.dart';
import 'package:dart_wormhole_gui/views/mobile/settings.dart';
import 'package:dart_wormhole_gui/views/mobile/splash.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/cupertino.dart';

PageRouteBuilder? Function(RouteSettings) getMobileRoutes(Config config) {
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
      case SEND_ROUTE:
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
