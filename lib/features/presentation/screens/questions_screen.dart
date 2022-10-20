import 'package:firebase_study_app/core/Routes/routes_name.dart';
import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/custom_test_styles.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:firebase_study_app/core/dependency_injection.dart/injections.dart';
import 'package:firebase_study_app/features/data/Repositories/firebase_database_repository.dart';
import 'package:firebase_study_app/features/domain/models/answer.dart';
import 'package:firebase_study_app/features/domain/models/question_papers.dart';
import 'package:firebase_study_app/features/domain/models/questions.dart';
import 'package:firebase_study_app/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:firebase_study_app/features/presentation/bloc/questions_bloc/questions_bloc.dart';
import 'package:firebase_study_app/features/presentation/cubit/all_answered_questions_cubit/all_answerd_questions_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/current_question_cubit/current_question_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/question_timer_cubit/question_timer_cubit.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/background_decoration.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/content_area.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/custom_appbar.dart';
import 'package:firebase_study_app/features/presentation/widgets/questions/question_answers_appbar_leading.dart';
import 'package:firebase_study_app/features/presentation/widgets/questions/question_answers_appbar_title.dart';
import 'package:firebase_study_app/features/presentation/widgets/questions/question_answers_widget.dart';
import 'package:firebase_study_app/features/presentation/widgets/questions/questions_navigator.dart';
import 'package:firebase_study_app/features/presentation/widgets/questions/questions_shimmer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({Key? key, required this.questionPapersModel})
      : super(key: key);

  final QuestionPapersModel questionPapersModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<QuestionsBloc, QuestionsState>(
        listener: (context, state) {
          //Start timer
          if (state.status == QuestionsStatus.success) {
            BlocProvider.of<QuestionTimerCubit>(context)
                .startTimer(timeSeconds: questionPapersModel.timeSeconds);
          }
        },
        builder: (context, state) {
          Map<QuestionsModel, AnswersModel?> answeredQuestions =
              context.select((AllAnswerdQuestionsCubit b) => b.state);
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: CustomAppBar(
                titleWidget: QuestionAnswersAppBarTitle(
                    allQuestions: state.allQuestions),
                leading: const QuestionAnswersAppBarLeading(),
                showActionIcon: true,
                onMenuActionTap: () {
                  BlocProvider.of<NavigatorBloc>(context).add(PushNamed(
                      route: Routes.TestOverviewScreen,
                      objectParam: answeredQuestions));
                },
              ),
              body: BackgroundDecoration(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.status == QuestionsStatus.loading)
                    const Expanded(
                        child: ContentArea(child: QuestionsShimmer())),
                  if (state.status == QuestionsStatus.success)
                    // BlocProvider(
                    //   create: (context) => AllAnswerdQuestionsCubit(
                    //       questions: state.allQuestions!),
                    //   child:

                    Expanded(
                      child: ContentArea(
                        child: Column(
                          children: [
                            BlocBuilder<CurrentQuestionCubit, QuestionsModel?>(
                              builder: (context, currentQuestionState) {
                                return QuestionAnswersWidget(
                                    currentQuestion: currentQuestionState ??
                                        state.allQuestions![0]);
                              },
                            ),
                            BlocBuilder<CurrentQuestionCubit, QuestionsModel?>(
                              builder: (context, currentQuestionState) {
                                // Map<QuestionsModel, AnswersModel?>
                                //     answeredQuestions = context.select(
                                //         (AllAnswerdQuestionsCubit b) =>
                                //             b.state);
                                return QuestionsNavigator(
                                  complete: () {
                                    context.read<NavigatorBloc>().add(PushNamed(
                                        route: Routes.TestOverviewScreen,
                                        objectParam: answeredQuestions));
                                  },
                                  next: () {
                                    BlocProvider.of<CurrentQuestionCubit>(
                                            context)
                                        .nextQuestion(
                                            currentQuestion:
                                                currentQuestionState ??
                                                    state.allQuestions![0],
                                            allQuestions: state.allQuestions!);
                                  },
                                  previous: () {
                                    BlocProvider.of<CurrentQuestionCubit>(
                                            context)
                                        .previousQuestion(
                                            currentQuestion:
                                                currentQuestionState ??
                                                    state.allQuestions![0],
                                            allQuestions: state.allQuestions!);
                                  },
                                  isCompleted: currentQuestionState ==
                                      state.allQuestions!.last,
                                  showPreviousIcon: currentQuestionState != null
                                      ? currentQuestionState !=
                                          state.allQuestions!.first
                                      : false,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  // ),
                ],
              )));
        },
      ),
    )
        //,
        //)
        ;
  }
}
