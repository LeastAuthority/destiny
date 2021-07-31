import 'package:flutter/material.dart';
import 'views/introduction-slider.dart';
import 'views/splash.dart';
import 'views/send.dart';
import 'package:flutter/widgets.dart';
import 'views/home.dart';
import 'views/receive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
            return ScreenUtilInit(
                designSize: Size(375,590),
                builder:()=> MaterialApp(
                      // theme: new ThemeData(scaffoldBackgroundColor: Colors.black12),
                      routes: {
                            '/': (context) => Splash(),
                            '/intro': (context) => IntroScreen(),
                            '/home': (context) => Home(),
                            '/send': (context) => SendDefault(),
                            '/receive': (context) => Receive(),
                      },
                ));
      }
}