import 'package:firebase_study_app/core/configs/themes/app_dark_theme.dart';
import 'package:firebase_study_app/core/configs/themes/app_light_theme.dart';
import 'package:flutter/material.dart';

const double _mobileScreenPadding = 25.0;
const double _cardBorderRadius = 10.0;

double get mobileScreenPadding => _mobileScreenPadding;
double get cardBorderRadius => _cardBorderRadius;

class UIParameters {
  static BorderRadius get cardCircularBorderRadius =>
      BorderRadius.circular(_cardBorderRadius);
  static EdgeInsets get mobileScreenpadding =>
      const EdgeInsets.all(_mobileScreenPadding);

  static bool isdarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static ThemeData buildLightTheme(BuildContext context) {
    return isdarkMode(context)
        ? DarkTheme().buildDarkTheme()
        : LightTheme().buildLightTheme();
  }
}
