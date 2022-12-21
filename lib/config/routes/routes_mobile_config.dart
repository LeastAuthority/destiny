import 'package:destiny/config/routes/routes.dart';
import 'package:destiny/views/mobile/Info.dart';
import 'package:destiny/views/mobile/introduction-slider.dart';
import 'package:destiny/views/mobile/receive/receive.dart';
import 'package:destiny/views/mobile/send/send.dart';
import 'package:destiny/views/mobile/splash.dart';
import 'package:flutter/cupertino.dart';

PageRouteBuilder? Function(RouteSettings) getMobileRoutes() {
  return (RouteSettings settings) {
    switch (settings.name) {
      case SPLASH_ROUTE:
        {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => Splash());
        }
      case INTRO_ROUTE:
        {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => IntroScreen());
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
          return PageRouteBuilder(pageBuilder: (_, __, ___) => Info());
        }
    }
    return null;
  };
}
