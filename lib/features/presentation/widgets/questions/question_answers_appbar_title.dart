import 'package:firebase_study_app/core/configs/themes/custom_test_styles.dart';
import 'package:firebase_study_app/features/domain/models/questions.dart';
import 'package:firebase_study_app/features/presentation/cubit/current_question_cubit/current_question_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionAnswersAppBarTitle extends StatelessWidget {
  const QuestionAnswersAppBarTitle({Key? key, this.allQuestions})
      : super(key: key);

  final List<QuestionsModel>? allQuestions;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentQuestionCubit, QuestionsModel?>(
      builder: (context, currentQuestionState) {
        int? questionNumber = allQuestions == null
            ? 0
            : currentQuestionState == null
                ? 1
                : allQuestions!.indexOf(currentQuestionState) + 1;

        return Text(
          "Q. ${questionNumber.toString().padLeft(2, '0')}",
          style: appBarTS,
        );
      },
    );
  }
}
