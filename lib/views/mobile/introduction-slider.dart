import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/constants/asset_path.dart';
import 'package:destiny/views/mobile/send/send.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen();

  @override
  IntroScreenState createState() => new IntroScreenState();
}

// ------------------ Custom config ------------------
class IntroScreenState extends State<IntroScreen> {
  IntroScreenState();

  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
          title: END_TO_END_ENCRYPTION,
          description:
              SEND_AND_RECEIVE_FILES_SECURELY_WITH_SIMPLICITY_AND_SPEED,
          subTitleTextFontSize: 14.0,
          titleTextFontSize: 23.0,
          btnTitle: NEXT,
          pathImage: INTRO_LOGO,
          backgroundColor: Colors.black,
          heightImage: 300.0),
    );
    slides.add(
      new Slide(
          title: NO_SIGN_UP,
          description: SEND_AND_RECEIVE_FILES_WITH_NO_NEED_TO_SIGN_UP,
          subTitleTextFontSize: 14.0,
          titleTextFontSize: 23.0,
          pathImage: PRIVACY_IMG,
          backgroundColor: Colors.black,
          btnTitle: NEXT,
          heightImage: 300.0),
    );
    slides.add(
      new Slide(
          title: DEVICE_TO_DEVICE,
          description: SEND_AND_RECEIVE_FROM_AND_TO_YOUR_DEVICE_WITHOUT_STORING,
          subTitleTextFontSize: 14.0,
          titleTextFontSize: 23.0,
          btnTitle: GET_STARTED,
          maxLineTextDescription: 3,
          pathImage: DEVICE_TO_DEVICE_IMG,
          backgroundColor: Colors.black,
          heightImage: 300.0),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SendScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 590),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        home: new IntroSlider(
          slides: this.slides,
          showSkipBtn: false,
          showNextBtn: false,
          termsLink: TERMS_LINK,
          showPrevBtn: false,
          showDoneBtn: false,
          onDonePress: this.onDonePress,
          colorDot: Theme.of(context).scaffoldBackgroundColor,
          colorActiveDot: Theme.of(context).colorScheme.secondary,
          sizeDot: 13.0,
          hideStatusBar: false,
          backgroundColorAllSlides: Colors.grey,
          verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
        ),
        // this allows to disable debug label
        debugShowCheckedModeBanner: true,
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
      ),
    );
  }
}
