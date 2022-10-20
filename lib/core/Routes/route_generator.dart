import 'package:firebase_study_app/core/Routes/routes_name.dart';
import 'package:firebase_study_app/core/utils/string_extensions.dart';
import 'package:firebase_study_app/features/domain/models/answer.dart';
import 'package:firebase_study_app/features/domain/models/question_papers.dart';
import 'package:firebase_study_app/features/domain/models/questions.dart';
import 'package:firebase_study_app/features/presentation/screens/404.dart';
import 'package:firebase_study_app/features/presentation/screens/answer_check_screen.dart';
import 'package:firebase_study_app/features/presentation/screens/app_introduction_screen.dart';
import 'package:firebase_study_app/features/presentation/screens/home_screen.dart';
import 'package:firebase_study_app/features/presentation/screens/login_screen.dart';
import 'package:firebase_study_app/features/presentation/screens/questions_screen.dart';
import 'package:firebase_study_app/features/presentation/screens/result_screen.dart';
import 'package:firebase_study_app/features/presentation/screens/splash_screen.dart';
import 'package:firebase_study_app/features/presentation/screens/test_overview_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routesSettings) {
    var routingData = routesSettings.name!.getRoutingdata;

    switch (routingData.route) {
      //exemple with datas in path

      case Routes.SplashRoute:
        return CustomRoute(
          builder: (context) => const SplashScreen(),
          settings: routesSettings,
        );
      case Routes.HomeRoute:
        return CustomRoute(
          builder: (context) => const HomeScreen(),
          settings: routesSettings,
        );

      case Routes.LogInRoute:
        return CustomRoute(
          builder: (context) => const LoginScreen(),
          settings: routesSettings,
        );

      case Routes.AppIntroductionRoute:
        return CustomRoute(
          builder: (context) => const AppIntroductionScreen(),
          settings: routesSettings,
        );

      case Routes.QuestionsSRoute:
        final questionPapersModel =
            routesSettings.arguments as QuestionPapersModel;
        return CustomRoute(
          builder: (context) =>
              QuestionsScreen(questionPapersModel: questionPapersModel),
          settings: routesSettings,
        );

      case Routes.TestOverviewScreen:
        final answeredQuestions =
            routesSettings.arguments as Map<QuestionsModel, AnswersModel?>;
        return CustomRoute(
          builder: (context) =>
              TestOverviewScreen(answeredQuestions: answeredQuestions),
          settings: routesSettings,
        );

      case Routes.ResultScreen:
        final answeredQuestions =
            routesSettings.arguments as Map<QuestionsModel, AnswersModel?>;
        return CustomRoute(
          builder: (context) =>
              ResultScreen(answeredQuestions: answeredQuestions),
          settings: routesSettings,
        );

       case Routes.AnswercheckScreen:
        final answeredQuestions =
            routesSettings.arguments as Map<QuestionsModel, AnswersModel?>;
        return CustomRoute(
          builder: (context) =>
              AnswercheckScreen(answeredQuestions: answeredQuestions),
          settings: routesSettings,
        );

      default:
        return CustomRoute(
          builder: (context) => const PageNotFound(),
          settings: routesSettings,
        );
    }
  }
}

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return FadeTransition(opacity: animation, child: child);
    //return new FadeTransition(opacity: animation, child: child);
  }
}
