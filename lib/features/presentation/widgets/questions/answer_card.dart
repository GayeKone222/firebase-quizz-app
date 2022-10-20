import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard(
      {Key? key,
      required this.answer,
      this.isSelected = false,
      required this.onTap,
      this.color})
      : super(key: key);

  final String answer;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: UIParameters.cardCircularBorderRadius,
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: UIParameters.cardCircularBorderRadius,
              color: color?.withOpacity(0.5) ??
                  (isSelected
                      ? answerSelectedColor(context)
                      : Theme.of(context).cardColor),
              border: Border.all(
                  color: isSelected
                      ? answerSelectedColor(context)
                      : answerBorderColor(context))),
          child: Text(
            answer,
            style: TextStyle(
                color: color ?? (isSelected ? onSurfaceTextColor : null)),
          ),
        ));
  }
}
