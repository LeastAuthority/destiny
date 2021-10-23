import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'send/send.dart';


class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => new IntroScreenState();
}

// ------------------ Custom config ------------------
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "End-to-End Encryption",
        description: "Send & receive files securely with simplicity & speed.",
        pathImage: "assets/images/intro-logo.png",
        backgroundColor: Colors.black,
        // widthImage: 300.0,
        heightImage: 300.0
      ),
    );
    slides.add(
      new Slide(
        title: "No Sign-Up",
        description: "Send & receive files with no need to sign up.",
        pathImage: "assets/images/privacy.png",
        backgroundColor: Colors.black,
        // widthImage: 300.0,
        heightImage: 300.0
      ),
    );
    slides.add(
      new Slide(
        title: "Device to Device",
        description: "Send & receive from & to your device without storing data in the cloud.",
        pathImage: "assets/images/device-device.png",
        backgroundColor: Colors.black,
        // widthImage: 300.0,
        heightImage: 300.0
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SendDefault()),
    );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffF3B4BA),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffF3B4BA),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffF3B4BA),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0x33F3B4BA)),
      overlayColor: MaterialStateProperty.all<Color>(Color(0x33FFA8B0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,
      showSkipBtn: false,
      showNextBtn: false,
      showPrevBtn: false,
      //showDoneBtn: false,

      // Skip button
      // renderSkipBtn: this.renderSkipBtn(),
      // skipButtonStyle: myButtonStyle(),

      // Next button
      // renderNextBtn: this.renderNextBtn(),
      // nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      doneButtonStyle: myButtonStyle(),
      // Dot indicator
      colorDot: Theme.of(context).scaffoldBackgroundColor,
      colorActiveDot: Theme.of(context).colorScheme.secondary,
      sizeDot: 13.0,

      // Show or hide status bar
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,

      // Scrollbar
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}