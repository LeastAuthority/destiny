import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/splash.dart';

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


}
