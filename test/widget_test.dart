// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/home.dart';
import 'package:dart_wormhole_gui/views/receive.dart';
import 'package:dart_wormhole_gui/views/splash.dart';
import 'package:dart_wormhole_gui/widgets/Button.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';
import 'package:dart_wormhole_gui/views/send.dart';

import 'package:flutter/material.dart';
 import 'package:flutter_test/flutter_test.dart';
import 'package:dart_wormhole_gui/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //    await tester.pumpWidget(MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
   testWidgets('Splash screen', (WidgetTester tester) async {
     await tester.pumpWidget(
       MaterialApp(
         home: ScreenUtilInit(
             designSize: Size(375,590), builder: () => Splash()),
       ),
     );
  //   SplashState splashState = SplashState();
    // bool isItFirstLunch = await splashState.isItAppFirstLunch();
     // Create the Finders.
     final splashScreenBody = find.byKey(Key(SPLASH_SCREEN_BODY));
     final splashScreenLoading = find.byKey(Key(SPLASH_SCREEN_LOADING));

     expect(splashScreenBody, findsOneWidget);
     expect(splashScreenLoading, findsOneWidget);
    // expect(isItFirstLunch, true);

   });
   testWidgets('Slider screen', (WidgetTester tester) async {
     await tester.pumpWidget(
       MaterialApp(
         home: ScreenUtilInit(
             designSize: Size(375,590), builder: () => Splash()),
       ),
     );
     
     final splashScreenBody = find.byKey(Key(SPLASH_SCREEN_BODY));
     final splashScreenLoading = find.byKey(Key(SPLASH_SCREEN_LOADING));

     expect(splashScreenBody, findsOneWidget);
     expect(splashScreenLoading, findsOneWidget);
     // expect(isItFirstLunch, true);

   });
   testWidgets('Send screen', (WidgetTester tester) async {
     await tester.pumpWidget(
       MaterialApp(
         home: ScreenUtilInit(
             designSize: Size(375,590), builder: () => SendDefault()),
       ),
     );

     // Create the Finders.
     final bottomNav = find.byKey(Key(BOTTOM_NAV_BAR));
     final navbar = find.byKey(Key(CUSTOM_NAV_BAR));
     final sendScreenContent = find.byKey(Key(SEND_SCREEN_CONTENT));
     final sendScreenHeading = find.byKey(Key(SEND_SCREEN_HEADING));
     final sendScreenBottomPlaceholder = find.byKey(Key(SEND_SCREEN_BOTTOM_SPACE_PLACEHOLDER));
     final sendScreenSelectAFileButton = find.byKey(Key(SEND_SCREEN_SELECT_A_FILE_BUTTON));
     // final sendScreenCodeGenerationUI = find.byKey(Key(SEND_SCREEN_CODE_GENERATION_UI));


     expect(navbar, findsOneWidget);
     expect(bottomNav, findsOneWidget);
     expect(sendScreenContent, findsOneWidget);
     expect(sendScreenHeading, findsOneWidget);
     expect(sendScreenBottomPlaceholder, findsOneWidget);
     expect(sendScreenSelectAFileButton, findsOneWidget);
     // expect(sendScreenCodeGenerationUI, findsOneWidget);
   });

   testWidgets('Receive screen', (WidgetTester tester) async {
     await tester.pumpWidget(
       MaterialApp(
         home: ScreenUtilInit(
             designSize: Size(375,590), builder: () => Receive()),
       ),
     );

     // Create the Finders.
     final bottomNav = find.byKey(Key(BOTTOM_NAV_BAR));
     final navbar = find.byKey(Key(CUSTOM_NAV_BAR));

     final receiveScreenBody = find.byKey(Key(RECEIVE_SCREEN_BODY));
     final receiveScreenContent = find.byKey(Key(RECEIVE_SCREEN_CONTENT));
     final receiveScreenHeading = find.byKey(Key(RECEIVE_SCREEN_HEADING));
     final receiveScreenEnterCode = find.byKey(Key(RECEIVE_SCREEN_ENTER_CODE));

     expect(navbar, findsOneWidget);
     expect(bottomNav, findsOneWidget);
     expect(receiveScreenBody, findsOneWidget);
     expect(receiveScreenContent, findsOneWidget);

     expect(receiveScreenHeading, findsOneWidget);
     expect(receiveScreenEnterCode, findsOneWidget);

   });
}
