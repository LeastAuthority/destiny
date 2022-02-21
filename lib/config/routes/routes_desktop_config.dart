import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/views/desktop/receive/receive.dart';
import 'package:dart_wormhole_gui/views/desktop/send/send.dart';
import 'package:dart_wormhole_gui/views/desktop/settings.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/cupertino.dart';

PageRouteBuilder? Function(RouteSettings) getDesktopRoutes(Config config) {
  return (RouteSettings settings) {
    switch (settings.name) {
      case DESKTOP_SEND_ROUTE:
        {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => Send(config));
        }
      case RECEIVE_ROUTE:
        {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => Receive(config));
        }
      case SETTINGS_ROUTE:
        {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => Settings());
        }
    }
    return null;
  };
}
