import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/custom_test_styles.dart';
import 'package:flutter/material.dart';

class CountDownTimer extends StatelessWidget {
  const CountDownTimer({Key? key, this.color, required this.time})
      : super(key: key);
  final Color? color;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: color ?? onSurfaceTextColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          time,
          style: countDownTimerTS(context).copyWith(color: color),
        ),
      ],
    );
  }
}
