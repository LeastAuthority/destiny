import 'package:destiny/config/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ScreenUtilInit testApp(Widget widget) {
  return testAppBuild(() => widget);
}

ScreenUtilInit testAppBuild(Widget Function() buildWidget) {
  return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () {
        WidgetsFlutterBinding.ensureInitialized();
        return MaterialApp(
          theme: CustomTheme.darkThemeMobile,
          home: buildWidget(),
        );
      });
}
