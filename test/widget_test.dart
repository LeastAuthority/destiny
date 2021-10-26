import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/settings.dart';
import 'package:dart_wormhole_gui/views/splash.dart';
import 'package:dart_wormhole_gui/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/widgets/custom-bottom-bar.dart';

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
