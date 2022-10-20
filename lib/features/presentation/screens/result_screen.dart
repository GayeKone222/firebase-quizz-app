import 'package:firebase_study_app/core/Routes/routes_name.dart';
import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/custom_test_styles.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:firebase_study_app/features/domain/models/answer.dart';
import 'package:firebase_study_app/features/domain/models/auth_details_model.dart';
import 'package:firebase_study_app/features/domain/models/question_papers.dart';
import 'package:firebase_study_app/features/domain/models/questions.dart';
import 'package:firebase_study_app/features/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:firebase_study_app/features/presentation/bloc/db_firebaseuplaod_bloc/db_firebase_upload_bloc.dart';
import 'package:firebase_study_app/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:firebase_study_app/features/presentation/cubit/all_answered_questions_cubit/all_answerd_questions_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/current_question_cubit/current_question_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/question_papers_cubit/question_papers_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/question_timer_cubit/question_timer_cubit.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/background_decoration.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/content_area.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/custom_appbar.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/main_button.dart';
import 'package:firebase_study_app/features/presentation/widgets/test_overview_widget/question_number_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key, required this.answeredQuestions})
      : super(key: key);

  final Map<QuestionsModel, AnswersModel?> answeredQuestions;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // print("answeredQuestions :$answeredQuestions");
    // answeredQuestions.forEach((key, value) {
    //   print("\n\nkey : $key");
    //   print("\nvalue : $value");
    // });
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          leading: const SizedBox(
            height: 80,
          ),
          title:
              '${answeredQuestions.entries.where((e) => e.key.correctAnswer == e.value!.identifier).length} out of ${answeredQuestions.length} are correct',
        ),
        body: BackgroundDecoration(
          child: Column(children: [
            Expanded(
                child: ContentArea(
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/bulb.svg'),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Text(
                      "Congratulations",
                      style:
                          headerText.copyWith(color: resultTextColor(context)),
                    ),
                  ),
                  Text("You have 10 points",
                      style: TextStyle(color: resultTextColor(context))),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Tap bellow question numbers to view correct answers",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: answeredQuestions.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: width ~/ 75,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          itemBuilder: (BuildContext context, int index) {
                            AnswerStatus? answerStatus;
                            AnswersModel? answer =
                                answeredQuestions.values.toList()[index];
                            // AnswerStatus? answerStatus =
                            //     answeredQuestions.values.toList()[index] != null
                            //         ? AnswerStatus.answered
                            //         : null;

                            QuestionsModel question = answeredQuestions.keys
                                .firstWhere(
                                    (k) => answeredQuestions[k] == answer);

                            if (question.correctAnswer == answer!.identifier) {
                              answerStatus = AnswerStatus.correct;
                            } else {
                              answerStatus = AnswerStatus.wrong;
                            }

                            return QuestionNumberCard(
                              index: index + 1,
                              status: answerStatus,
                              onTap: () {
                                //get the tapped question
                                var questionsModel = answeredQuestions.entries
                                    .toList()[index]
                                    .key;
                                // //get the tapped question
                                // var questionsModel = answeredQuestions.keys
                                //     .firstWhere((k) =>
                                //         answeredQuestions[k] ==
                                //         answeredQuestions.values
                                //             .toList()[index]);
                                //set the tapped question view
                                context
                                    .read<CurrentQuestionCubit>()
                                    .setQuestion(questionsModel);
                                // //navigate back
                                BlocProvider.of<NavigatorBloc>(context).add(
                                    PushNamed(
                                        route: Routes.AnswercheckScreen,
                                        objectParam: answeredQuestions));
                              },
                            );
                          })),
                  Builder(builder: (context) {
                    final user = context
                        .select<AuthenticationBloc, AuthenticationDetailModel?>(
                            (AuthenticationBloc b) => b.state.user);
                    final questionPapers = context
                        .select<QuestionPapersCubit, QuestionPapersModel?>(
                            (QuestionPapersCubit b) => b.state);
                    return Padding(
                      padding: UIParameters.mobileScreenpadding,
                      child: Row(children: [
                        Expanded(
                            child: MainButton(
                          onTap: () {
                            //reset all selected answers

                            BlocProvider.of<AllAnswerdQuestionsCubit>(context)
                                .reset();

                            //init current question

                            BlocProvider.of<CurrentQuestionCubit>(context)
                                .setQuestion(questionPapers!.questions.first);

                            //navigate to QuestionsSRoute view
                            BlocProvider.of<NavigatorBloc>(context).add(
                                PushNamedAndRemoveUntil(
                                    route: Routes.QuestionsSRoute,
                                    untilRoute: Routes.HomeRoute,
                                    objectParam: questionPapers));

                            //start timer
                            BlocProvider.of<QuestionTimerCubit>(context)
                                .startTimer(
                                    timeSeconds: questionPapers.timeSeconds);
                          },
                          title: "Try again",
                          color: Colors.blueGrey,
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Builder(builder: (context) {
                          return MainButton(
                            onTap: () {
                              if (user != null && questionPapers != null) {
                                context.read<DbFirebaseUploadBloc>().add(
                                    SaveTestResult(
                                        user: user,
                                        questionPapers: questionPapers));
                                BlocProvider.of<NavigatorBloc>(context)
                                    .add(const PushReplacementNamed(
                                  route: Routes.HomeRoute,
                                ));
                              }
                            },
                            title: "Go home",
                            color: onSurfaceTextColor,
                          );
                        }))
                      ]),
                    );
                  })
                ],
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
