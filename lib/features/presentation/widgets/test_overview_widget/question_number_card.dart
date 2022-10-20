// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

enum AnswerStatus { correct, wrong, notAnswered, answered }

class QuestionNumberCard extends StatelessWidget {
  const QuestionNumberCard(
      {Key? key, required this.index, this.status, required this.onTap})
      : super(key: key);
  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor = Theme.of(context).primaryColor;

    switch (status) {
      case AnswerStatus.answered:
        _backgroundColor = UIParameters.isdarkMode(context)
            ? Theme.of(context).cardColor
            : Theme.of(context).primaryColor;
        break;

      case AnswerStatus.correct:
        _backgroundColor = correctAnswerColor;

        break;

      case AnswerStatus.wrong:
        _backgroundColor = wrongAnswerColor;

        break;

      case AnswerStatus.notAnswered:
        _backgroundColor = UIParameters.isdarkMode(context)
            ? Colors.red.withOpacity(0.5)
            : Theme.of(context).primaryColor.withOpacity(0.1);

        break;
      default:
        _backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }

    return InkWell(
      onTap: onTap,
        borderRadius: UIParameters.cardCircularBorderRadius,
        child: Ink(
          padding: UIParameters.mobileScreenpadding,
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: UIParameters.cardCircularBorderRadius,
          ),
          child: Center(
              child: Text(
            '$index',
            style: TextStyle(
                color: status == AnswerStatus.notAnswered
                    ? Theme.of(context).primaryColor
                    : onSurfaceTextColor),
          )),
        ));
  }
}
