import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/views/desktop/receive/receive.dart';
import 'package:dart_wormhole_gui/views/desktop/send/send.dart';
import 'package:dart_wormhole_gui/views/desktop/settings.dart';
import 'package:flutter/cupertino.dart';

PageRouteBuilder? getDesktopRoutes (RouteSettings settings) {
  switch (settings.name) {
    case '/': {
      return PageRouteBuilder(pageBuilder: (_, __, ___) => Send());
    }
    break;
    case RECEIVE_ROUTE: {
      return PageRouteBuilder(pageBuilder: (_, __, ___) => Receive());
    }
    break;
    case SETTINGS_ROUTE: {
      return PageRouteBuilder(pageBuilder: (_, __, ___) => Settings());
    }
    break;
  }
  return null;
}