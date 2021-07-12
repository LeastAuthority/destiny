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
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    //Navigator.pushNamed(context, '/intro');
    if (_seen) {
      Navigator.pushNamed(context, '/home');
    } else {
      await prefs.setBool('seen', true);
      Navigator.pushNamed(context, '/intro');
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();
  @override
  Widget build(BuildContext context) {
    checkFirstSeen();

    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }
}