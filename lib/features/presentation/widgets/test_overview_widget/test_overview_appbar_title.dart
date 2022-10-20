import 'package:firebase_study_app/core/configs/themes/custom_test_styles.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/countdown_timer.dart';
import 'package:flutter/material.dart';

class TestOverviewappBarTitle extends StatelessWidget {
  const TestOverviewappBarTitle({Key? key, required this.remaininTimeState})
      : super(key: key);

  final String remaininTimeState;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CountDownTimer(
          color: countDownTimerTS(context).color, time: remaininTimeState),
      Text(
        " Remaining",
        style: countDownTimerTS(context),
      )
    ]);
  }
}
