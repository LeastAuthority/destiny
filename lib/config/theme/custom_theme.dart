import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class CustomTheme {
  static ThemeData get darkThemeMobile {
    return ThemeData(
      primaryColor: CustomColors.purple,
      primaryColorLight: CustomColors.lightPurple,
      primaryColorDark: CustomColors.darkPurple,
      scaffoldBackgroundColor: CustomColors.darkBlue,
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: CustomColors.purple,
          linearTrackColor: CustomColors.superLightPurple),
      disabledColor: CustomColors.babyPowderLight,
      bottomAppBarTheme: BottomAppBarTheme(color: CustomColors.lighterBlack),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: CustomColors.babyPowder),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 25.0.sp,
            color: CustomColors.babyPowder,
            fontFamily: MONTSERRAT_EXTRA_BOLD),
        headline2: TextStyle(
            fontSize: 20.0.sp,
            color: CustomColors.black,
            fontFamily: MONTSERRAT_MEDIUM),
        headline3: TextStyle(
            fontSize: 20.0.sp,
            color: CustomColors.babyPowder,
            fontFamily: MONTSERRAT),
        headline4: TextStyle(
            fontSize: 17.0.sp,
            color: CustomColors.babyPowder,
            fontFamily: MONTSERRAT_MEDIUM),
        headline5: TextStyle(
            fontSize: 17.0.sp,
            color: CustomColors.babyPowder,
            fontFamily: MONTSERRAT_LIGHT),
        headline6: TextStyle(
            fontSize: 14.0.sp,
            color: CustomColors.babyPowder,
            fontFamily: MONTSERRAT_LIGHT),
        subtitle1: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 14.sp,
          fontFamily: MONTSERRAT_MEDIUM,
        ),
        subtitle2: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 12.sp,
          fontFamily: MONTSERRAT,
        ),
        bodyText1: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 12.sp,
          fontFamily: MONTSERRAT_LIGHT,
        ),
        bodyText2: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 12.sp,
          fontFamily: MONTSERRAT,
        ),
      ),
    );
  }

  static ThemeData get darkThemeDesktop {
    return ThemeData(
      primaryColor: CustomColors.purple,
      cardColor: CustomColors.lightBlue,
      primaryColorDark: CustomColors.darkPurple,
      primaryColorLight: CustomColors.mediumPurple,
      scaffoldBackgroundColor: CustomColors.darkBlue,
      dialogBackgroundColor: CustomColors.lightBlack,
      backgroundColor: CustomColors.darkBlue,
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: CustomColors.purple,
          linearTrackColor: CustomColors.superLightPurple),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: CustomColors.babyPowder,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: CustomColors.babyPowder,
          fontSize: 25.sp,
          fontFamily: MONTSERRAT_THIN,
        ),
        headline2: TextStyle(
          color: CustomColors.babyPowder,
          fontSize: 20.sp,
          fontFamily: MONTSERRAT_MEDIUM,
        ),
        headline3: TextStyle(
          color: CustomColors.babyPowder,
          fontSize: 17.sp,
          fontFamily: MONTSERRAT_EXTRA_BOLD,
        ),
        headline4: TextStyle(
          color: CustomColors.babyPowder,
          fontSize: 12.sp,
          fontFamily: MONTSERRAT_SEMI_BOLD,
        ),
        headline5: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 17.sp,
          fontFamily: MONTSERRAT,
        ),
        headline6: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 17.sp,
          fontFamily: MONTSERRAT_THIN,
        ),
        bodyText1: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 22.sp,
          fontFamily: MONTSERRAT_THIN,
        ),
        subtitle1: TextStyle(
          color: CustomColors.black,
          fontSize: 17.sp,
          fontFamily: MONTSERRAT_LIGHT,
        ),
        subtitle2: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 17.sp,
          fontFamily: MONTSERRAT_LIGHT,
        ),
      ),
    );
  }
}
