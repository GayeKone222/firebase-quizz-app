import 'package:firebase_study_app/core/configs/themes/app_light_theme.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

const onSurfaceTextColor = Colors.white;
const Color correctAnswerColor = Color(0xFF3ac3cb);
const Color wrongAnswerColor = Color(0xFFf85187);
const Color notAnsweredColor = Color(0xFF2a3c65);

  

//light theme
const Color primaryLightColorLight = Color(0xFF3ac3cb);
const Color primaryColorLight = Color(0xFFf85187);
const mainTextColorLight = Color(0xFF282828);
const _customScaffoldColorLight = Color.fromARGB(255, 240, 237, 255);
const cardColorLight = Color.fromARGB(255, 254, 254, 255);

//dark them
const Color primaryDarkColorDark = Color(0xFF2e3c62);
const Color primaryColorDark = Color(0xFF99ace1);
const mainTextColorDark = Colors.white;
const _customScaffoldColorDark = Color(0xFF2e3c62);

const mainGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLightColorLight, primaryColorLight]);

const mainGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDarkColorDark, primaryColorDark]);

LinearGradient mainGradient(BuildContext context) =>
    UIParameters.isdarkMode(context) ? mainGradientDark : mainGradientLight;

Color customScaffoldColor(BuildContext context) =>
    UIParameters.isdarkMode(context)
        ? _customScaffoldColorDark
        : _customScaffoldColorLight;

Color answerSelectedColor(BuildContext context) =>
    UIParameters.isdarkMode(context)
        ? Theme.of(context).cardColor.withOpacity(0.5)
        : Theme.of(context).primaryColor;

Color answerBorderColor(BuildContext context) =>
    UIParameters.isdarkMode(context)
        ? const Color.fromARGB(255, 20, 46, 158)
        : const Color.fromARGB(255, 221, 221, 221);


Color resultTextColor(BuildContext context) =>
    UIParameters.isdarkMode(context)
        ? Colors.white
        : Theme.of(context).primaryColor;
