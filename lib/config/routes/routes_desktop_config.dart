import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/views/desktop/send/send.dart';

// TODO temporarily using mobile screens for desktop
import 'package:dart_wormhole_gui/views/mobile/receive/receive.dart';
import 'package:dart_wormhole_gui/views/mobile/settings.dart';
import 'package:flutter/cupertino.dart';

PageRouteBuilder? getDesktopRoutes(RouteSettings settings) {
  switch (settings.name) {
    case DESKTOP_SEND_ROUTE:
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
