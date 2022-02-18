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
      scaffoldBackgroundColor: CustomColors.veryDarkBlue,
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: CustomColors.purple,
          linearTrackColor: CustomColors.superLightPurple),
      disabledColor: CustomColors.babyPowderLight,
      appBarTheme: AppBarTheme(backgroundColor: CustomColors.veryDarkPurple),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: CustomColors.babyPowder),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 20.0.sp,
            color: CustomColors.babyPowder,
            fontFamily: MONTSERRAT,
            fontWeight: FontWeight.w500),
        headline2: TextStyle(
            fontSize: 17.0.sp,
            color: CustomColors.babyPowder,
            fontFamily: MONTSERRAT_MEDIUM),
        headline3: TextStyle(
            fontSize: 17.0.sp,
            color: CustomColors.babyPowder,
            fontFamily: LATO,
            fontWeight: FontWeight.w500),
        headline4: TextStyle(
            fontSize: 17.0.sp,
            color: CustomColors.babyPowder,
            fontFamily: MONTSERRAT,
            fontWeight: FontWeight.w300),
        headline5: TextStyle(
            fontSize: 12.0.sp,
            color: CustomColors.babyPowder,
            fontFamily: MONTSERRAT,
            fontWeight: FontWeight.w400),
        bodyText1: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          fontFamily: MONTSERRAT,
        ),
        bodyText2: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 12.sp,
          fontWeight: FontWeight.w300,
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
          fontSize: 22.sp,
          fontFamily: MONTSERRAT_MEDIUM,
        ),
        headline3: TextStyle(
          color: CustomColors.babyPowder,
          fontSize: 17.sp,
          fontFamily: ROBOTO,
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
        bodyText1: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 22.sp,
          fontFamily: MONTSERRAT_THIN,
        ),
        subtitle1: TextStyle(
          color: CustomColors.black,
          fontSize: 17.sp,
          fontFamily: MONTSERRAT,
        ),
        subtitle2: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 12.sp,
          fontFamily: ROBOTO,
        ),
      ),
    );
  }
}
