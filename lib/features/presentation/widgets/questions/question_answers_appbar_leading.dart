import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/custom_test_styles.dart';
import 'package:firebase_study_app/features/presentation/cubit/question_timer_cubit/question_timer_cubit.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/countdown_timer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionAnswersAppBarLeading extends StatelessWidget {
  const QuestionAnswersAppBarLeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
          shape: StadiumBorder(
              side: BorderSide(color: onSurfaceTextColor, width: 2))),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: BlocBuilder<QuestionTimerCubit, String>(
        builder: (context, remainingTimerState) {
          return CountDownTimer(
            color: onSurfaceTextColor,
            time: remainingTimerState,
          );
        },
      ),
    );
  }
}
