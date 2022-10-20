import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_study_app/core/Routes/routes_name.dart';
import 'package:firebase_study_app/core/configs/themes/app_colors.dart';
import 'package:firebase_study_app/core/configs/themes/custom_test_styles.dart';
import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:firebase_study_app/core/utils/app_icons.dart';
import 'package:firebase_study_app/features/domain/models/question_papers.dart';
import 'package:firebase_study_app/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:firebase_study_app/features/presentation/bloc/questions_bloc/questions_bloc.dart';
import 'package:firebase_study_app/features/presentation/cubit/current_question_cubit/current_question_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/question_papers_cubit/question_papers_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/question_timer_cubit/question_timer_cubit.dart';
import 'package:firebase_study_app/features/presentation/widgets/common_widgets/app_icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.model,
  }) : super(key: key);
  final QuestionPapersModel model;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
//double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardCircularBorderRadius,
          color: Theme.of(context).cardColor),
      child: InkWell(
        onTap: () {
          //cancel timer if it is already active
          BlocProvider.of<QuestionTimerCubit>(context).closeTimer();

          //set current questionsPaper

          context
              .read<QuestionPapersCubit>()
              .setCurrentQuestionPapersModel(currentQuestionPaper: model);

          //reinit and get all related questions
          context.read<QuestionsBloc>()
            ..add(ReInitialise())
            ..add(GetAllQuestions(questionPapersModel: model));

           //set selected question to null
           context
              .read<CurrentQuestionCubit>()
              .setQuestion(null);

          //

          //navigate to QuestionsSRoute view
          BlocProvider.of<NavigatorBloc>(context).add(
              PushNamed(route: Routes.QuestionsSRoute, objectParam: model));
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: SizedBox(
                        height: width * 0.15,
                        width: width * 0.15,
                        child: CachedNetworkImage(
                          imageUrl: model.imageUrl!,

                          //  state
                          //     .allPaperImages![index].imageUrl!,
                          placeholder: (context, url) =>
                              Image.memory(kTransparentImage),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.title, style: cardTitles(context)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                          child: Text(
                            model.description,
                          ),
                        ),
                        Row(
                          children: [
                            AppIconText(
                              icon: Icon(
                                Icons.help_outline_sharp,
                                color: UIParameters.isdarkMode(context)
                                    ? onSurfaceTextColor
                                    : Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4),
                              ),
                              text: Text(
                                '${model.questionCount} questions',
                                style: detailText.copyWith(
                                    color: UIParameters.isdarkMode(context)
                                        ? onSurfaceTextColor
                                        : Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.4)),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            AppIconText(
                              icon: Icon(
                                Icons.timer,
                                color: UIParameters.isdarkMode(context)
                                    ? onSurfaceTextColor
                                    : Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4),
                              ),
                              text: Text(
                                model.timeInMinutes(),
                                style: detailText.copyWith(
                                    color: UIParameters.isdarkMode(context)
                                        ? onSurfaceTextColor
                                        : Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.4)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: -cardBorderRadius,
                  right: -cardBorderRadius,
                  child: GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(cardBorderRadius),
                                bottomRight:
                                    Radius.circular(cardBorderRadius))),
                        child: const Icon(AppIcons.trophyOutline
                            // Icons.wine_bar,
                            //color: Colors.red,
                            )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
