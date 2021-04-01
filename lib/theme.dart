import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fiveoclock/models/my_theme_provider.dart';

import 'constants.dart';
import 'size_config.dart';

// Our light/Primary Theme
ThemeData themeData(BuildContext context) {
  return ThemeData(
      brightness: Brightness.light,
      appBarTheme: appBarTheme,
      primaryColor: kPrimaryColor,
      accentColor: kAccentLightColor,
      scaffoldBackgroundColor: kBackgroundLightColor,
      shadowColor: kShadowColorLight1,
      colorScheme: ColorScheme.light(
        secondary: kShadowColorLight2, background: kBackgroundLightColor,
        surface: Colors.white,
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
      brightness: Brightness.dark,
      primaryColor: kPrimaryColor,
      accentColor: kAccentDarkColor,
      scaffoldBackgroundColor: kBackgroundDarkColor,
      shadowColor: kShadowColorDark1,
      appBarTheme: appBarTheme,
      colorScheme: ColorScheme.dark(
          secondary: kShadowColorDark2,
          background: kBackgroundDarkColor,
          surface: Colors.black),
      backgroundColor: kBackgroundDarkColor,
      iconTheme: IconThemeData(color: kBodyTextColorDark),
      accentIconTheme: IconThemeData(color: kAccentIconDarkColor),
      primaryIconTheme: IconThemeData(color: kPrimaryIconLightColor),
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        bodyText1: TextStyle(color: kShadowColorDark2, fontSize: 12),
        bodyText2: TextStyle(color: kShadowColorDark2),
        headline5: TextStyle(
            color: kTitleTextDarkColor,
            fontSize: 32), //getProportionateTextSize(32)),
        headline4: TextStyle(
          color: kTitleTextDarkColor,
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

AppBarTheme appBarTheme = AppBarTheme(color: Colors.transparent, elevation: 0);
/*
class MyShadows {
  static const primaryLightShadow =
  (themeData(context).isLightTheme) ? Shadow(color: kShadowColorLight1, blurRadius: 30, offset: Offset(18, 18)) : Shadow(color: kShadowColorLight1, blurRadius: 30, offset: Offset(18, 18)),
    

 static const secondaryLightShadow =
    Shadow(color: kShadowColorLight2, blurRadius: 30, offset: Offset(-18, -18));
}
*/