import 'package:dart_wormhole_gui/views/mobile/receive/receive.dart';
import 'package:dart_wormhole_gui/views/mobile/send/send.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/settings.dart';
import 'package:dart_wormhole_gui/views/mobile/splash.dart';

 void main() {
   testWidgets('Splash screen', (WidgetTester tester) async {
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

   testWidgets('Settings screen', (WidgetTester tester) async {
     await tester.pumpWidget(
       MaterialApp(
         home: ScreenUtilInit(
             designSize: Size(375,590), builder: () => Settings()),
       ),
     );
     final settingsScreenBody = find.byKey(Key(SETTINGS_SCREEN_BODY));

     expect(settingsScreenBody, findsOneWidget);
   });

   testWidgets('Custom App Bar', (WidgetTester tester) async {
     await tester.pumpWidget(
         MaterialApp(
             home: Scaffold(
                appBar:  CustomAppBar(
                 key: Key(CUSTOM_NAV_BAR),
                 title: SETTINGS
               ),
         ))
     );
     final customNavbarBody = find.byKey(Key(CUSTOM_NAV_BAR_BODY));
     final customNavbarContainer = find.byKey(Key(CUSTOM_NAV_BAR_CONTAINER));
     final customNavbarLeftItem = find.byKey(Key(CUSTOM_NAV_BAR_LEFT_ITEM));
     final customNavbarRightItem = find.byKey(Key(CUSTOM_NAV_BAR_RIGHT_ITEM));
     final customNavbarMiddleItem = find.byKey(Key(CUSTOM_NAV_BAR_MIDDLE_ITEM));

     expect(customNavbarBody, findsOneWidget);
     expect(customNavbarContainer, findsOneWidget);
     expect(customNavbarLeftItem, findsOneWidget);
     expect(customNavbarRightItem, findsOneWidget);
     expect(customNavbarMiddleItem, findsOneWidget);
   });

   testWidgets('Custom BottomBar', (WidgetTester tester) async {
     await tester.pumpWidget(
         MaterialApp(
             home: Scaffold(
                 bottomNavigationBar: CustomBottomBar(
                 path: SEND_ROUTE,
                 key: Key(BOTTOM_NAV_BAR),
               ),
             ))
     );
     final bottomBarBody = find.byKey(Key(BOTTOM_NAV_BAR_BODY));
     final bottomNavbarContainer = find.byKey(Key(BOTTOM_NAV_BAR_CONTAINER));
     final bottomNavbarLeftItem = find.byKey(Key(BOTTOM_NAV_BAR_LEFT_ITEM));
     final bottomNavbarRightItem = find.byKey(Key(BOTTOM_NAV_BAR_RIGHT_ITEM));

     expect(bottomBarBody, findsOneWidget);
     expect(bottomNavbarContainer, findsOneWidget);
     expect(bottomNavbarLeftItem, findsOneWidget);
     expect(bottomNavbarRightItem, findsOneWidget);
   });
}
