import 'dart:io';

import 'package:destiny/views/shared/receive.dart';
import 'package:destiny/views/shared/send.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:get_it/get_it.dart';

import 'config/routes/routes_desktop_config.dart';
import 'config/routes/routes_mobile_config.dart';
import 'config/theme/custom_theme.dart';
import 'constants/app_constants.dart';
import 'generated/codegen_loader.g.dart';
import 'generated/locale_keys.g.dart';
import 'locator.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

Future<void> startApp(Config c) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  register(getIt, c);

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(900, 800));
    setWindowMaxSize(const Size(1600, 1200));
    setWindowFrame(Rect.fromLTWH(0, 0, 900, 800));
  }
  runApp(localized(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => SendSharedState(c)),
    ChangeNotifierProvider(create: (context) => ReceiveSharedState(c))
  ], child: MyApp())));
}

Widget localized(Widget widget) {
  return EasyLocalization(
    supportedLocales: [Locale('de'), Locale('en')],
    path: 'assets/translations',
    assetLoader: CodegenLoader(),
    fallbackLocale: Locale('en'),
    child: widget,
  );
}

void main() {
  final Config magicWormholeIO = Config(
    rendezvousUrl: "ws://relay.magic-wormhole.io:4000/v1",
    transitRelayUrl: "tcp://transit.magic-wormhole.io:4001",
  );
  startApp(magicWormholeIO);
}

class MyApp extends StatelessWidget {
  MyApp();

  Widget onGenerateRoute(BuildContext context) {
    return ScreenUtilInit(
      designSize: selectSize(),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute: selectRoutes(),
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          WidgetsFlutterBinding.ensureInitialized();
          if (!Platform.isAndroid && !Platform.isIOS) {
            setWindowTitle(LocaleKeys.window_title.tr());
          }
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        theme: (Platform.isAndroid || Platform.isIOS)
            ? CustomTheme.darkThemeMobile
            : CustomTheme.darkThemeDesktop,
        // this allows to disable debug label
        debugShowCheckedModeBanner: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return onGenerateRoute(context);
  }
}

Size selectSize() {
  return (Platform.isAndroid || Platform.isIOS)
      ? Size(375, 690)
      : Size(1280, 800);
}

PageRouteBuilder? Function(RouteSettings p1) selectRoutes() {
  return (Platform.isAndroid || Platform.isIOS)
      ? getMobileRoutes()
      : getDesktopRoutes();
}
