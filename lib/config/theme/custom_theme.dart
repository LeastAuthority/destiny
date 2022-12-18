import 'package:destiny/constants/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get darkThemeMobile {
    const primaryColor = CustomColors.purple;
    const primaryColorLight = CustomColors.lightPurple;

    final ButtonStyle textButtonStyle = TextButton.styleFrom(
      foregroundColor: CustomColors.darkPurple,
      backgroundColor: CustomColors.darkBlue,
      minimumSize: Size(88, 36),
      // padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );

    final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: CustomColors.purple,
      backgroundColor: CustomColors.darkPurple,
      minimumSize: Size(88, 36),
      //padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    return ThemeData(
      primaryColor: primaryColor,
      primaryColorLight: primaryColorLight,
      primaryColorDark: CustomColors.darkPurple,
      scaffoldBackgroundColor: CustomColors.darkBlue,
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: primaryColor, linearTrackColor: CustomColors.superLightPurple),
      disabledColor: CustomColors.babyPowderLight,
      bottomAppBarTheme: BottomAppBarTheme(color: CustomColors.lighterBlack),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: CustomColors.babyPowder, brightness: Brightness.dark),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 25.0.sp,
            color: CustomColors.babyPowder,
            fontFamily: MONTSERRAT_EXTRA_BOLD),
        headline2: TextStyle(
            fontSize: 20.0.sp,
            color: CustomColors.babyPowder,
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
      buttonTheme: ButtonThemeData(focusColor: primaryColor),
      textButtonTheme: TextButtonThemeData(style: textButtonStyle),
      elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: CustomColors.darkPurple,
        selectionHandleColor: primaryColor,
      ),
      focusColor: primaryColor,
      hintColor: primaryColorLight,
      inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      )),
    );
  }

  static ThemeData get darkThemeDesktop {
    return darkThemeMobile.copyWith(
      cardColor: CustomColors.lightBlue,
      dialogBackgroundColor: CustomColors.lightBlack,
      backgroundColor: CustomColors.darkBlue,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: CustomColors.babyPowder,
          fontSize: 25.0,
          fontFamily: MONTSERRAT_THIN,
        ),
        headline2: TextStyle(
          color: CustomColors.babyPowder,
          fontSize: 20.0,
          fontFamily: MONTSERRAT_MEDIUM,
        ),
        headline3: TextStyle(
          color: CustomColors.babyPowder,
          fontSize: 17.0,
          fontFamily: MONTSERRAT_EXTRA_BOLD,
        ),
        headline4: TextStyle(
          color: CustomColors.babyPowder,
          fontSize: 14.0,
          fontFamily: MONTSERRAT_SEMI_BOLD,
        ),
        headline5: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 17.0,
          fontFamily: MONTSERRAT,
        ),
        headline6: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 17.0,
          fontFamily: MONTSERRAT_THIN,
        ),
        bodyText1: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 22.0,
          fontFamily: MONTSERRAT_THIN,
        ),
        subtitle1: TextStyle(
          color: CustomColors.babyPowderLight,
          fontSize: 17.0,
          fontFamily: MONTSERRAT_LIGHT,
        ),
        subtitle2: TextStyle(
          color: CustomColors.black,
          fontSize: 17.0,
          fontFamily: MONTSERRAT_LIGHT,
        ),
      ),
    );
  }
}
