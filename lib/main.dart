import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/config/theme/custom_theme.dart';
import 'package:dart_wormhole_gui/views/introduction-slider.dart';
import 'package:dart_wormhole_gui/views/settings.dart';
import 'package:dart_wormhole_gui/views/splash.dart';
import 'package:dart_wormhole_gui/views/send/send.dart';
import 'package:dart_wormhole_gui/views/receive/receive.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
            return ScreenUtilInit(
                designSize: Size(375,590),
                builder:()=> MaterialApp(
                     theme: CustomTheme.darkTheme,
                      onGenerateRoute: (settings) {
                       switch (settings.name) {
                         case SPLASH_ROUTE: {
                           return PageRouteBuilder(pageBuilder: (_, __, ___) => Splash());
                         }
                         break;
                         case INTRO_ROUTE: {
                           return PageRouteBuilder(pageBuilder: (_, __, ___) => IntroScreen());
                         }
                         break;
                         case SEND_ROUTE: {
                           return PageRouteBuilder(pageBuilder: (_, __, ___) => SendDefault());
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
                      },
                ));
      }
}