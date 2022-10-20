import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_study_app/core/Routes/navigation_service.dart';
import 'package:firebase_study_app/core/Routes/route_generator.dart';
import 'package:firebase_study_app/core/Routes/routes_name.dart';

import 'package:firebase_study_app/core/configs/themes/ui_parameters.dart';
import 'package:firebase_study_app/core/dependency_injection.dart/injections.dart';
import 'package:firebase_study_app/features/data/Repositories/firebase_auth_repository.dart';
import 'package:firebase_study_app/features/data/Repositories/firebase_database_repository.dart';
import 'package:firebase_study_app/features/data/providers/firebase_auth_providers.dart';
import 'package:firebase_study_app/features/data/providers/google_signin_provider.dart';
import 'package:firebase_study_app/features/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:firebase_study_app/features/presentation/bloc/db_firebaseuplaod_bloc/db_firebase_upload_bloc.dart';
import 'package:firebase_study_app/features/presentation/bloc/firebase_storage_bloc/firebase_storage_bloc.dart';
import 'package:firebase_study_app/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:firebase_study_app/features/presentation/bloc/questions_bloc/questions_bloc.dart';
import 'package:firebase_study_app/features/presentation/bloc/simple_bloc_observer.dart';
import 'package:firebase_study_app/features/presentation/cubit/all_answered_questions_cubit/all_answerd_questions_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/app_initialiser_cubit/app_initialiser_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/app_theme_cubit/app_theme_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/current_question_cubit/current_question_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/question_papers_cubit/question_papers_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/question_timer_cubit/question_timer_cubit.dart';
import 'package:firebase_study_app/features/presentation/screens/app_introduction_screen.dart';
import 'package:firebase_study_app/features/presentation/screens/home_screen.dart';
import 'package:firebase_study_app/firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupLocator();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp(
      // repositoryFireStoreDatabase: RepositoryFireStoreDatabase(),
      // repositoryFirebaseAuthentication: RepositoryFirebaseAuthentication(
      //   authenticationFirebaseProvider: FirebaseAuthenticationProvider(
      //     firebaseAuth: FirebaseAuth.instance,
      //   ),
      //   googleSignInProvider: GoogleSignInProvider(
      //     googleSignIn: GoogleSignIn(),
      //   ),
      // ),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    // required this.repositoryFireStoreDatabase,
    // required this.repositoryFirebaseAuthentication
  }) : super(key: key);

  // final RepositoryFireStoreDatabase repositoryFireStoreDatabase;
  // final RepositoryFirebaseAuthentication repositoryFirebaseAuthentication;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<DbFirebaseUploadBloc>(
        //   create: (BuildContext context) =>
        //       DbFirebaseUploadBloc(repository: repositoryFireStoreDatabase)..add(UploadDB()),
        // ),
        BlocProvider<DbFirebaseUploadBloc>(
            create: (BuildContext context) => locator<DbFirebaseUploadBloc>()
            // DbFirebaseUploadBloc(repository: repositoryFireStoreDatabase),
            ),

        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => locator<AuthenticationBloc>()
            // AuthenticationBloc(
            //     repository: repositoryFirebaseAuthentication,
            //     repositoryFireStoreDatabase: repositoryFireStoreDatabase)
            ..add(AuthenticationInit()),
        ),
        BlocProvider<AppThemeCubit>(
            create: (BuildContext context) => locator<AppThemeCubit>()
            //  AppThemeCubit(

            //     prefs:
            //     //themeData: UIParameters.buildLightTheme(context)

            //     )
            ),
        BlocProvider<FirebaseStorageBloc>(
          create: (BuildContext context) => locator<FirebaseStorageBloc>()
            //FirebaseStorageBloc(repository: repositoryFireStoreDatabase)
            ..add(GetAllPapersImages()),
        ),
        BlocProvider<NavigatorBloc>(
          create: (BuildContext context) => NavigatorBloc(),
        ),
        BlocProvider<AppInitialiserCubit>(
          create: (BuildContext context) => AppInitialiserCubit()..initApp(),
        ),
        BlocProvider<QuestionTimerCubit>(
          create: (BuildContext context) => QuestionTimerCubit(),
        ),
        BlocProvider<CurrentQuestionCubit>(
          create: (BuildContext context) => CurrentQuestionCubit(),
        ),

        BlocProvider<QuestionPapersCubit>(
          create: (BuildContext context) => QuestionPapersCubit(),
        ),
        BlocProvider<QuestionsBloc>(
          create: (BuildContext context) => locator<QuestionsBloc>(),
          lazy: false,
        ),
        BlocProvider<AllAnswerdQuestionsCubit>(
          create: (context) {
            //  List<QuestionsModel>? questions
            //               = context.select(
            //                 (QuestionsBloc b) =>
            //                     b.state.allQuestions);
            return locator<AllAnswerdQuestionsCubit>()
              // AllAnswerdQuestionsCubit(questionBloc: questionsBloc
              //     //     // questions: questions??[]

              //     )
              ..init();
          },
          lazy: false,
        )
      ],
      child: BlocBuilder<AppThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Quiz App',
            theme: state,
            home: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.status == AuthenticationStatus.authenticated) {
                  BlocProvider.of<NavigatorBloc>(context).add(
                      const PushReplacementNamed(
                          route: Routes.AppIntroductionRoute));
                }
                if (state.status == AuthenticationStatus.unAuthenticated) {
                  BlocProvider.of<NavigatorBloc>(context).add(
                      const PushReplacementNamed(route: Routes.LogInRoute));
                }
              },
              child: const AppIntroductionScreen(),
            ),
            navigatorKey: locator<NavigationService>().navigatorKey,
            initialRoute: Routes.SplashRoute,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }
}
