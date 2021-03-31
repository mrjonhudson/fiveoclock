import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'size_config.dart';

// Our light/Primary Theme
ThemeData themeData(BuildContext context) {
  return ThemeData(
      appBarTheme: appBarTheme,
      primaryColor: kPrimaryColor,
      accentColor: kAccentLightColor,
      scaffoldBackgroundColor: kBackgroundLightColor,
      colorScheme: ColorScheme.light(
          secondary: kSecondaryLightColor, background: kBackgroundLightColor
          // on light theme surface = Colors.white by default
          ),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: kBodyTextColorLight,
      ),
      accentIconTheme: IconThemeData(color: kAccentIconLightColor),
      primaryIconTheme: IconThemeData(color: kAccentIconDarkColor),
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        bodyText1: TextStyle(color: kShadowColorLight1, fontSize: 12),
        bodyText2: TextStyle(color: kShadowColorLight1),
        headline5: TextStyle(
            color: kTitleTextLightColor,
            fontSize: 32), //getProportionateTextSize(32)),
        headline4: TextStyle(
          color: kTitleTextLightColor,
          fontSize: 42, //getProportionateTextSize(42),
          fontWeight: FontWeight.w400,
        ),
        headline1: TextStyle(
          color: kPrimaryColor,
          fontSize: 72, //getProportionateTextSize(72),
          fontWeight: FontWeight.w600,
        ),
      ));
}

// Dark Theme
ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    accentColor: kAccentDarkColor,
    scaffoldBackgroundColor: Color(0xFF0D0C0E),
    appBarTheme: appBarTheme,
    colorScheme: ColorScheme.light(
      secondary: kSecondaryDarkColor,
      surface: kSurfaceDarkColor,
    ),
    backgroundColor: kBackgroundDarkColor,
    iconTheme: IconThemeData(color: kBodyTextColorDark),
    accentIconTheme: IconThemeData(color: kAccentIconDarkColor),
    primaryIconTheme: IconThemeData(color: kPrimaryIconDarkColor),
    textTheme: GoogleFonts.robotoMonoTextTheme().copyWith(
      bodyText1: TextStyle(color: kBodyTextColorDark),
      bodyText2: TextStyle(color: kBodyTextColorDark),
      headline5: TextStyle(color: kTitleTextDarkColor, fontSize: 24),
      headline4: TextStyle(color: kTitleTextDarkColor, fontSize: 32),
      headline1: TextStyle(color: kPrimaryColor, fontSize: 80),
    ),
  );
}

AppBarTheme appBarTheme = AppBarTheme(color: Colors.transparent, elevation: 0);
