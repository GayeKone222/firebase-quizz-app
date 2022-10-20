import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

TextStyle cardTitles(context) => TextStyle(
    color: UIParameters.isdarkMode(context)
        ? Theme.of(context).textTheme.bodyText1!.color
        : Theme.of(context).primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold);

const questionText = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

const detailText = TextStyle(
  fontSize: 12,
);

const headerText = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w700, color: onSurfaceTextColor);

const appBarTS = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w700, color: onSurfaceTextColor);

TextStyle countDownTimerTS(context) => TextStyle(
    letterSpacing: 2,
    color: UIParameters.isdarkMode(context)
        ? Theme.of(context).textTheme.bodyText1!.color
        : Theme.of(context).primaryColor);
