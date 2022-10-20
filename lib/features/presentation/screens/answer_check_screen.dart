import 'package:firebase_study_app/features/domain/models/answer.dart';
import 'package:firebase_study_app/features/domain/models/questions.dart';
import 'package:firebase_study_app/features/presentation/cubit/all_answered_questions_cubit/all_answerd_questions_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/current_question_cubit/current_question_cubit.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/background_decoration.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/custom_appbar.dart';
import 'package:firebase_study_app/features/presentation/widgets/questions/question_answers_appbar_title.dart';
import 'package:firebase_study_app/features/presentation/widgets/questions/question_answers_widget.dart';
import 'package:firebase_study_app/features/presentation/widgets/questions/questions_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswercheckScreen extends StatelessWidget {
  const AnswercheckScreen({Key? key, required this.answeredQuestions})
      : super(key: key);

  final Map<QuestionsModel, AnswersModel?> answeredQuestions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          titleWidget: QuestionAnswersAppBarTitle(
              allQuestions: answeredQuestions.keys.toList()),
          //leading: const QuestionAnswersAppBarLeading(),
          showActionIcon: false,
        ),
        body: BackgroundDecoration(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                children: [
                  BlocBuilder<CurrentQuestionCubit, QuestionsModel?>(
                    builder: (context, currentQuestionState) {
                      // return   BlocProvider(
                      //   create: (context) => AllAnswerdQuestionsCubit(
                      //       questions: answeredQuestions.keys.toList()),
                      //   child: 
                        
                       return QuestionAnswersWidget(
                          selectedAnswer:answeredQuestions[currentQuestionState]?? answeredQuestions.entries.first.value,
                          isClickable: false,
                            currentQuestion: currentQuestionState ??
                                answeredQuestions.keys.toList()[0])
                                //,
                                ;
                     // );
                    },
                  ),
                  BlocBuilder<CurrentQuestionCubit, QuestionsModel?>(
                    builder: (context, currentQuestionState) {
                      return QuestionsNavigator(
                        complete: () {},
                        next: () {
                          BlocProvider.of<CurrentQuestionCubit>(context)
                              .nextQuestion(
                                  currentQuestion: currentQuestionState ??
                                      answeredQuestions.keys.toList()[0],
                                  allQuestions:
                                      answeredQuestions.keys.toList());
                        },
                        previous: () {
                          BlocProvider.of<CurrentQuestionCubit>(context)
                              .previousQuestion(
                                  currentQuestion: currentQuestionState ??
                                      answeredQuestions.keys.toList()[0],
                                  allQuestions:
                                      answeredQuestions.keys.toList());
                        },
                        isCompleted: currentQuestionState ==
                            answeredQuestions.keys.toList().last,
                        showPreviousIcon: currentQuestionState != null
                            ? currentQuestionState !=
                                answeredQuestions.keys.toList().first
                            : false,
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        )));
  }
}
