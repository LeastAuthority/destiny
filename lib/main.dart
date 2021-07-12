import 'package:flutter/material.dart';
import 'views/introduction-slider.dart';
import 'views/splash.dart';
import 'views/send.dart';
import 'package:flutter/widgets.dart';
import 'views/home.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => Splash(),
    '/intro': (context) => IntroScreen(),
    '/home': (context) => Home(),
    '/send': (context) => Send(),
  },
));

