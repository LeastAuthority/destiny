import 'package:destiny/config/routes/routes.dart';
import 'package:destiny/config/theme/custom_theme.dart';
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/views/mobile/receive/receive.dart';
import 'package:destiny/views/mobile/send/send.dart';
import 'package:destiny/views/mobile/Info.dart';
import 'package:destiny/views/mobile/splash.dart';
import 'package:destiny/views/mobile/widgets/custom-app-bar.dart';
import 'package:destiny/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Size mobileScreenSize = Size(375, 590);
  ScreenUtilInit getScreenUtilInit(Widget? screen, ThemeData theme, Size size) {
    return ScreenUtilInit(
      designSize: size,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        home: screen,
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 0.5),
            child: widget!,
          );
        },
        theme: theme,
      ),
    );
  }

  testWidgets('Splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScreenUtilInit(
            designSize: mobileScreenSize, builder: () => Splash()),
      ),
    );
    final splashScreenBody = find.byKey(Key(SPLASH_SCREEN_BODY));
    final splashScreenLoading = find.byKey(Key(SPLASH_SCREEN_LOADING));
    expect(splashScreenBody, findsOneWidget);
    expect(splashScreenLoading, findsOneWidget);
  });

  testWidgets('Send screen', (WidgetTester tester) async {
    await tester.pumpWidget(getScreenUtilInit(
        SendScreen(), CustomTheme.darkThemeMobile, Size(375, 590)));

    final bottomNav = find.byKey(Key(BOTTOM_NAV_BAR));
    final navbar = find.byKey(Key(CUSTOM_NAV_BAR));
    final sendScreenContent = find.byKey(Key(SEND_SCREEN_CONTENT));
    final sendScreenHeading = find.byKey(Key(SEND_SCREEN_HEADING));
    final sendScreenBottomPlaceholder =
        find.byKey(Key(SEND_SCREEN_BOTTOM_SPACE_PLACEHOLDER));
    final sendScreenSelectAFileButton =
        find.byKey(Key(SEND_SCREEN_SELECT_A_FILE_BUTTON));
    // final sendScreenCodeGenerationUI = find.byKey(Key(SEND_SCREEN_CODE_GENERATION_UI));

    expect(navbar, findsOneWidget);
    expect(bottomNav, findsOneWidget);
    expect(sendScreenContent, findsOneWidget);
    expect(sendScreenHeading, findsOneWidget);
    expect(sendScreenBottomPlaceholder, findsOneWidget);
    expect(sendScreenSelectAFileButton, findsOneWidget);
    // expect(sendScreenCodeGenerationUI, findsOneWidget);
  });
  //
  testWidgets('Receive screen', (WidgetTester tester) async {
    await tester.pumpWidget(getScreenUtilInit(
        ReceiveScreen(), CustomTheme.darkThemeMobile, mobileScreenSize));
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
    await tester.pumpWidget(getScreenUtilInit(
        Info(), CustomTheme.darkThemeMobile, mobileScreenSize));
    final settingsScreenBody = find.byKey(Key(SETTINGS_SCREEN_BODY));

    expect(settingsScreenBody, findsOneWidget);
  });

  testWidgets('Custom App Bar', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      appBar: CustomAppBar(key: Key(CUSTOM_NAV_BAR), title: SETTINGS),
    )));
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
    await tester.pumpWidget(getScreenUtilInit(
        Scaffold(
            bottomNavigationBar: CustomBottomBar(
          path: SEND_ROUTE,
          key: Key(BOTTOM_NAV_BAR),
        )),
        CustomTheme.darkThemeMobile,
        mobileScreenSize));

    final bottomBarBody = find.byKey(Key(BOTTOM_NAV_BAR_BODY));
    final bottomNavbarContainer = find.byKey(Key(BOTTOM_NAV_BAR_CONTAINER));
    final bottomNavbarLeftItem = find.byKey(Key(BOTTOM_NAV_BAR_LEFT_ITEM));
    // final bottomNavbarRightItem = find.byKey(Key(BOTTOM_NAV_BAR_RIGHT_ITEM));

    expect(bottomBarBody, findsOneWidget);
    expect(bottomNavbarContainer, findsOneWidget);
    expect(bottomNavbarLeftItem, findsOneWidget);
    // expect(bottomNavbarRightItem, findsOneWidget);
  });
}
