
import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/sub_theme_data_mixin.dart';
import 'package:flutter/material.dart';




class DarkTheme with SubThemeData {
 ThemeData buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      primaryColor:primaryColorDark ,
         visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: getIconTheme(),
        textTheme: gettextThemes()
            .apply(bodyColor: mainTextColorDark, displayColor: mainTextColorDark));
  }
}
