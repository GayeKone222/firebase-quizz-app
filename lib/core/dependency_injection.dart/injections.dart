import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_study_app/core/Routes/navigation_service.dart';
import 'package:firebase_study_app/features/data/Repositories/firebase_auth_repository.dart';
import 'package:firebase_study_app/features/data/Repositories/firebase_database_repository.dart';
import 'package:firebase_study_app/features/data/providers/firebase_auth_providers.dart';
import 'package:firebase_study_app/features/data/providers/google_signin_provider.dart';
import 'package:firebase_study_app/features/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:firebase_study_app/features/presentation/bloc/db_firebaseuplaod_bloc/db_firebase_upload_bloc.dart';
import 'package:firebase_study_app/features/presentation/bloc/firebase_storage_bloc/firebase_storage_bloc.dart';
import 'package:firebase_study_app/features/presentation/bloc/questions_bloc/questions_bloc.dart';
import 'package:firebase_study_app/features/presentation/cubit/all_answered_questions_cubit/all_answerd_questions_cubit.dart';
import 'package:firebase_study_app/features/presentation/cubit/app_theme_cubit/app_theme_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  locator.registerLazySingleton(() => NavigationService());

//Blocs
  locator.registerFactory(() => DbFirebaseUploadBloc(
        repository: locator(),
      ));

  locator.registerFactory(() => AuthenticationBloc(
        repository: locator(),
        repositoryFireStoreDatabase: locator(),
      ));

  locator.registerFactory(() => AppThemeCubit(
        prefs: locator(),
      ));

  locator.registerFactory(() => FirebaseStorageBloc(
        repository: locator(),
      ));

  locator.registerLazySingleton<QuestionsBloc>(() => QuestionsBloc(
        repository: locator(),
      ));

  locator
      .registerFactory<AllAnswerdQuestionsCubit>(() => AllAnswerdQuestionsCubit(
            questionBloc: locator(),
          ));

//repositories
  locator.registerLazySingleton<RepositoryFireStoreDatabase>(
      () => RepositoryFireStoreDatabase(fireStore: locator()));
  locator.registerLazySingleton<RepositoryFirebaseAuthentication>(() =>
      RepositoryFirebaseAuthentication(
          authenticationFirebaseProvider: locator(),
          googleSignInProvider: locator()));

//providers
  locator.registerLazySingleton<FirebaseAuthenticationProvider>(
      () => FirebaseAuthenticationProvider(firebaseAuth: locator()));

  locator.registerLazySingleton<GoogleSignInProvider>(
      () => GoogleSignInProvider(googleSignIn: locator()));

  // Externals
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  locator.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  locator
      .registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
}
