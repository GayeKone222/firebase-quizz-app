
import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/sub_theme_data_mixin.dart';
import 'package:flutter/material.dart';



class LightTheme with SubThemeData {
 ThemeData buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      cardColor: cardColorLight,
      primaryColor:primaryColorLight ,
      visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: getIconTheme(),
        textTheme: gettextThemes()
            .apply(bodyColor: mainTextColorLight, displayColor: mainTextColorLight));
  }
}
