import 'package:firebase_study_app/core/Routes/routes_name.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:firebase_study_app/features/domain/models/answer.dart';
import 'package:firebase_study_app/features/domain/models/questions.dart';
import 'package:firebase_study_app/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:firebase_study_app/features/presentation/cubit/current_question_cubit/current_question_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/question_timer_cubit/question_timer_cubit.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/background_decoration.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/content_area.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/custom_appbar.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/main_button.dart';
import 'package:firebase_study_app/features/presentation/widgets/test_overview_widget/question_number_card.dart';
import 'package:firebase_study_app/features/presentation/widgets/test_overview_widget/test_overview_appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestOverviewScreen extends StatelessWidget {
  const TestOverviewScreen({Key? key, required this.answeredQuestions})
      : super(key: key);

  final Map<QuestionsModel, AnswersModel?> answeredQuestions;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title:
              '${answeredQuestions.entries.where((e) => e.value != null).length} out of ${answeredQuestions.length} answered',
        ),
        body: BackgroundDecoration(
            child: Column(
          children: [
            Expanded(
                child: ContentArea(
                    child: Column(
              children: [
                BlocBuilder<QuestionTimerCubit, String>(
                  builder: (context, remaininTimeState) {
                    return TestOverviewappBarTitle(
                      remaininTimeState: remaininTimeState,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: answeredQuestions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: width ~/ 75,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        itemBuilder: (BuildContext context, int index) {
                          AnswerStatus? answerStatus =
                              answeredQuestions.values.toList()[index] != null
                                  ? AnswerStatus.answered
                                  : null;

                          return QuestionNumberCard(
                            index: index + 1,
                            status: answerStatus,
                            onTap: () {
                              //get the tapped question
                              var questionsModel =
                                  answeredQuestions.entries.toList()[index].key;

                              //set the tapped question view
                              context
                                  .read<CurrentQuestionCubit>()
                                  .setQuestion(questionsModel);
                              //navigate back
                              BlocProvider.of<NavigatorBloc>(context)
                                  .add(Pop());
                            },
                          );
                        })

                    //  Text(
                    //       '${answeredQuestions.values.toList()[index] != null}',
                    //       style: const TextStyle(fontSize: 16),
                    //     )

                    // ),
                    ),
                if (answeredQuestions.entries
                    .where((e) => e.value == null)
                    .isEmpty)
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: UIParameters.mobileScreenpadding,
                      child: MainButton(
                        onTap: () {
                          //cancel timer
                          //cancel timer if it is already active
                          BlocProvider.of<QuestionTimerCubit>(context)
                              .closeTimer();
                          //navigate
                          context.read<NavigatorBloc>().add(PushNamed(
                              route: Routes.ResultScreen,
                              objectParam: answeredQuestions));
                        },
                        title: "Complete",
                      ),
                    ),
                  )
              ],
            )))
          ],
        )));
  }
}
