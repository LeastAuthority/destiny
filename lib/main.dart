import 'dart:io';

import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routes/routes_desktop_config.dart';
import 'config/routes/routes_mobile_config.dart';
import 'config/theme/custom_theme.dart';
import 'constants/app_constants.dart';

void startApp(Config c) {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp(c));
}

void main() {
  startApp(magic_wormhole_io);
}

class MyApp extends StatelessWidget {
  late final Config config;

  MyApp(this.config);

  Widget onGenerateRoute() {
    if (Platform.isAndroid) {
      return ScreenUtilInit(
          designSize: Size(375, 590),
          builder: () => MaterialApp(
                theme: CustomTheme.darkThemeMobile,
                onGenerateRoute: getMobileRoutes(config),
              ));
    }

    return ScreenUtilInit(
        designSize: Size(1280, 800),
        builder: () => MaterialApp(
              theme: CustomTheme.darkThemeDesktop,
              onGenerateRoute: getDesktopRoutes(config),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return onGenerateRoute();
  }
}
