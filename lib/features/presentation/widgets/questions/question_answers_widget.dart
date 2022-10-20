import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/custom_test_styles.dart';
import 'package:firebase_study_app/features/domain/models/answer.dart';
import 'package:firebase_study_app/features/domain/models/questions.dart';
import 'package:firebase_study_app/features/presentation/cubit/all_answered_questions_cubit/all_answerd_questions_cubit.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/content_area.dart';
import 'package:firebase_study_app/features/presentation/widgets/questions/answer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionAnswersWidget extends StatelessWidget {
  const QuestionAnswersWidget(
      {Key? key,
      required this.currentQuestion,
      this.isClickable = true,
      this.selectedAnswer})
      : super(key: key);

  final QuestionsModel currentQuestion;
  final bool isClickable;
  final AnswersModel? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currentQuestion.question,
                style: questionText,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 25),
                  itemBuilder: (context, index) => BlocBuilder<
                          AllAnswerdQuestionsCubit,
                          Map<QuestionsModel, AnswersModel?>>(
                        builder: (context, questionAnswerstate) {
                          //if not clickable it means we are in answers check phase

                          return AnswerCard(
                              color: !isClickable
                                  ? currentQuestion.answers[index]
                                                  .identifier ==
                                              currentQuestion.correctAnswer &&
                                          currentQuestion.correctAnswer ==
                                              selectedAnswer!.identifier
                                      ? correctAnswerColor
                                      : currentQuestion.answers[index]
                                                      .identifier ==
                                                  currentQuestion
                                                      .correctAnswer &&
                                              currentQuestion.correctAnswer !=
                                                  selectedAnswer!.identifier
                                          ? correctAnswerColor
                                          : currentQuestion.correctAnswer !=
                                                      selectedAnswer!
                                                          .identifier &&
                                                  selectedAnswer!
                                                          .identifier ==
                                                      currentQuestion
                                                          .answers[index]
                                                          .identifier
                                              ? wrongAnswerColor
                                              : currentQuestion.answers[index]
                                                          .identifier !=
                                                      selectedAnswer!
                                                          .identifier
                                                  ? null
                                                  : null
                                  : null,
                              answer:
                                  '${currentQuestion.answers[index].identifier}. ${currentQuestion.answers[index].answer}',
                              isSelected: !isClickable
                                  ? false
                                  : questionAnswerstate[currentQuestion] ==
                                      currentQuestion.answers[index],
                              onTap: isClickable
                                  ? () {
                                      BlocProvider.of<
                                                  AllAnswerdQuestionsCubit>(
                                              context)
                                          .selectAnswer(
                                              currentQuestion:
                                                  currentQuestion,
                                              selectedAnswer: currentQuestion
                                                  .answers[index]);
                                    }
                                  : () {});
                        },
                      ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                        height: 10,
                      ),
                  itemCount: currentQuestion.answers.length),
            ],
          ));
    }));
  }
}
