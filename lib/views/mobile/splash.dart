import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // Navigator.pushNamed(context, INTRO_ROUTE);
    if (isItFirstLunch) {
      Navigator.pushNamed(context, SEND_ROUTE);
    } else {
      await setSeenToTrue();
      Navigator.pushNamed(context, INTRO_ROUTE);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkFirstSeen();
    return Scaffold(
      body: Center(
        key: Key(SPLASH_SCREEN_BODY),
        child: Text(
          LOADING,
          key: Key(SPLASH_SCREEN_LOADING),
        ),
      ),
    );
  }
}
