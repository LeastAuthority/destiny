import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:destiny/config/routes/routes.dart';
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/locator.dart';
import 'package:destiny/main.dart';
import 'package:destiny/views/mobile/Info.dart';
import 'package:destiny/views/mobile/receive/receive.dart';
import 'package:destiny/views/mobile/send/send.dart';
import 'package:destiny/views/mobile/splash.dart';
import 'package:destiny/views/mobile/widgets/custom-app-bar.dart';
import 'package:destiny/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ui_support.dart';

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getDownloadsPath() async {
    return "downloads";
  }
}

void main() {
  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    PackageInfo.setMockInitialValues(
        appName: "abc",
        packageName: "com.example.example",
        version: "1.0",
        buildNumber: "2",
        buildSignature: "buildSignature",
        installerStore: "asdf");
    SharedPreferences.setMockInitialValues({});
    final Config local = Config(
        rendezvousUrl: "ws://localhost:4000/v1",
        transitRelayUrl: "tcp://localhost:4001");
    register(getIt, local);
    await getIt.allReady();
  });

  testWidgets('Splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(testAppBuild(() => Splash()));
    final splashScreenBody = find.byKey(Key(SPLASH_SCREEN_BODY));
    final splashScreenLoading = find.byKey(Key(SPLASH_SCREEN_LOADING));
    expect(splashScreenBody, findsOneWidget);
    expect(splashScreenLoading, findsOneWidget);
  });

  testWidgets('Send screen', (WidgetTester tester) async {
    await tester.pumpWidget(testAppBuild(() => SendScreen()));

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

  testWidgets('Receive screen', (WidgetTester tester) async {
    await tester.pumpWidget(testAppBuild(() => ReceiveScreen()));
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
    await tester.pumpWidget(testAppBuild(() => Info()));
    final settingsScreenBody = find.byKey(Key(SETTINGS_SCREEN_BODY));

    expect(settingsScreenBody, findsOneWidget);
  });

  testWidgets('Custom App Bar', (WidgetTester tester) async {
    await tester.pumpWidget(testAppBuild(
        () => CustomAppBar(key: Key(CUSTOM_NAV_BAR), title: SETTINGS)));
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
    await tester.pumpWidget(testAppBuild(
      () => Scaffold(
          bottomNavigationBar: CustomBottomBar(
        path: SEND_ROUTE,
        key: Key(BOTTOM_NAV_BAR),
      )),
    ));

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
