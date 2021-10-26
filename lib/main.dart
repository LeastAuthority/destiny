import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/routes/routes.dart';
import 'config/theme/custom_theme.dart';
import 'views/introduction-slider.dart';
import 'views/settings.dart';
import 'views/splash.dart';
import 'views/send/send.dart';
import 'package:flutter/widgets.dart';
import 'views/receive/receive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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