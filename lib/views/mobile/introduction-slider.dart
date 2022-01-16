import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/views/mobile/send/send.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';

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
          title: END_TO_END_ENCRYPTION,
          description:
              SEND_AND_RECEIVE_FILES_SECURELY_WITH_SIMPLICITY_AND_SPEED,
          btnTitle: GET_STARTED,
          pathImage: INTRO_LOGO,
          backgroundColor: Colors.black,
          heightImage: 300.0),
    );
    slides.add(
      new Slide(
          title: NO_SIGN_UP,
          description: SEND_AND_RECEIVE_FILES_WITH_NO_NEED_TO_SIGN_UP,
          pathImage: PRIVACY_IMG,
          backgroundColor: Colors.black,
          btnTitle: NEXT,
          heightImage: 300.0),
    );
    slides.add(
      new Slide(
          title: DEVICE_TO_DEVICE,
          description: SEND_AND_RECEIVE_FROM_AND_TO_YOUR_DEVICE_WITHOUT_STORING,
          btnTitle: START_HERE,
          maxLineTextDescription: 3,
          pathImage: DEVICE_TO_DEVICE_IMG,
          backgroundColor: Colors.black,
          heightImage: 300.0),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Send()),
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
      showDoneBtn: false,
      // Skip button
      // renderSkipBtn: this.renderSkipBtn(),
      // skipButtonStyle: myButtonStyle(),

      // Next button
      // renderNextBtn: this.renderNextBtn(),
      // nextButtonStyle: myButtonStyle(),

      // Done button
      // renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      // doneButtonStyle: myButtonStyle(),
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
