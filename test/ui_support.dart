import 'package:destiny/config/theme/custom_theme.dart';
import 'package:destiny/main.dart';
import 'package:destiny/views/shared/send.dart';
import 'package:destiny/views/shared/receive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

ScreenUtilInit testApp(Widget widget, [Size? size]) {
  return testAppBuild(() => widget, size);
}

ScreenUtilInit testAppBuild(Widget Function() buildWidget, [Size? size]) {
  return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () {
        WidgetsFlutterBinding.ensureInitialized();
        return MaterialApp(
            theme: CustomTheme.darkThemeMobile,
            onGenerateRoute: selectRoutes(),
            home: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => SendSharedState()),
                ChangeNotifierProvider(
                    create: (context) => ReceiveSharedState())
              ],
              child: buildWidget(),
            ));
      });
}
