import 'dart:io';

import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'views/introduction-slider.dart';
import 'views/splash.dart';
import 'views/send.dart';
import 'package:flutter/widgets.dart';
import 'views/receive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_size/window_size.dart';
import 'package:desktop_window/desktop_window.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
   DesktopWindow.setWindowSize(Size(360,640));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
            return ScreenUtilInit(
                designSize: Size(375,590),
                builder:()=> MaterialApp(
                      // theme: new ThemeData(scaffoldBackgroundColor: Colors.black12),
                      routes: {
                            SPLASH_ROUTE: (context) => Splash(),
                            INTRO_ROUTE: (context) => IntroScreen(),
                            // HOME_ROUTE: (context) => Home(),
                            SEND_ROUTE: (context) => SendDefault(),
                            RECEIVE_ROUTE: (context) => Receive(),
                      },
                ));
      }
}