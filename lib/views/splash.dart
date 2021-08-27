import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:after_layout/after_layout.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  SharedPreferences? prefs;
  Future isItAppFirstLunch() async {
    prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs?.getBool(SEEN) ?? false);
    return _seen;
  }
  Future setSeenToTrue() async {
    return prefs?.setBool(SEEN, true);
  }
  Future checkFirstSeen() async {
    bool isItFirstLunch = await isItAppFirstLunch();
   // Navigator.pushNamed(context, '/intro');
    if (isItFirstLunch) {
      Navigator.pushNamed(context, SEND_ROUTE);
    } else {
      await setSeenToTrue();
      Navigator.pushNamed(context, INTRO_ROUTE);
    }
  }
  //
  // @override
  // void afterFirstLayout(BuildContext context) => checkFirstSeen();
  @override
  Widget build(BuildContext context) {
    checkFirstSeen();
    return  Scaffold(
      body:  Center(
        key: Key(SPLASH_SCREEN_BODY),
        child:  Text(
          LOADING,
          key: Key(SPLASH_SCREEN_LOADING),
        ),
      ),
    );
  }
}