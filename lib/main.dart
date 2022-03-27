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
    return ScreenUtilInit(
      designSize: Platform.isAndroid ? Size(375, 590) : Size(1280, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        onGenerateRoute: Platform.isAndroid
            ? getMobileRoutes(config)
            : getDesktopRoutes(config),
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        theme: Platform.isAndroid
            ? CustomTheme.darkThemeMobile
            : CustomTheme.darkThemeDesktop,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return onGenerateRoute();
  }
}
