import 'package:firebase_study_app/core/configs/themes/app_dark_theme.dart';
import 'package:firebase_study_app/core/configs/themes/app_light_theme.dart';

import 'package:firebase_study_app/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<ThemeData> {
  AppThemeCubit(
      {
      //required ThemeData themeData
      required this.prefs})
      : super(prefs.get("theme") == null ||
                prefs.get("theme") == AppTheme.lightTheme.name
            ? DarkTheme().buildDarkTheme()
            : DarkTheme().buildDarkTheme());

  final SharedPreferences prefs;

  void onThemeChange({required AppTheme appTheme}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //SharedPreferences _prefs =prefs;

    if (appTheme == AppTheme.darkTheme) {
      await prefs.setString("theme", AppTheme.lightTheme.name);
      emit(DarkTheme().buildDarkTheme());
    } else {
      await prefs.setString("theme", AppTheme.darkTheme.name);
      emit(LightTheme().buildLightTheme());
    }
  }
}
