import 'dart:io';

import 'package:destiny/views/shared/receive.dart';
import 'package:destiny/views/shared/send.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

import 'config/routes/routes_desktop_config.dart';
import 'config/routes/routes_mobile_config.dart';
import 'config/theme/custom_theme.dart';
import 'constants/app_constants.dart';

void startApp(Config c) {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(900, 800));
    setWindowMaxSize(const Size(1600, 1200));
    setWindowFrame(Rect.fromLTWH(0, 0, 900, 800));
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => SendSharedState(c)),
    ChangeNotifierProvider(create: (context) => ReceiveSharedState(c))
  ], child: MyApp(c)));
}

void main() {
  startApp(magicWormholeIO);
}

class MyApp extends StatelessWidget {
  late final Config config;

  MyApp(this.config);

  Widget onGenerateRoute() {
    return ScreenUtilInit(
      designSize: (Platform.isAndroid || Platform.isIOS)
          ? Size(375, 590)
          : Size(1280, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        onGenerateRoute: (Platform.isAndroid || Platform.isIOS)
            ? getMobileRoutes(config)
            : getDesktopRoutes(config),
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          WidgetsFlutterBinding.ensureInitialized();
          if (!Platform.isAndroid && !Platform.isIOS) {
            setWindowTitle(WINDOW_TITLE);
          }
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        theme: (Platform.isAndroid || Platform.isIOS)
            ? CustomTheme.darkThemeMobile
            : CustomTheme.darkThemeDesktop,
        // this allows to disable debug label
        debugShowCheckedModeBanner: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return onGenerateRoute();
  }
}
