import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_study_app/features/data/Repositories/firebase_auth_repository.dart';
import 'package:firebase_study_app/features/data/Repositories/firebase_database_repository.dart';
import 'package:firebase_study_app/features/domain/models/auth_details_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final RepositoryFirebaseAuthentication repository;
  final RepositoryFireStoreDatabase repositoryFireStoreDatabase;

  StreamSubscription<AuthenticationDetailModel>? authStreamSub;

  @override
  Future<void> close() {
    authStreamSub?.cancel();
    return super.close();
  }

  AuthenticationBloc({
    required this.repository,
    required this.repositoryFireStoreDatabase,
  }) : super(const AuthenticationState()) {
    on<AuthenticationInit>(_onAuthenticationInit);
    on<AuthenticateWithGoogleSignIn>(_onAuthenticateWithGoogleSignIn);
    on<LogOut>(_onLogOut);
    on<AuthenticationStateChanged>(_onAuthenticationStateChanged);
  }

  // in order to make google signin work use :
  // https://stackoverflow.com/questions/54557479/flutter-and-google-sign-in-plugin-platformexceptionsign-in-failed-com-google

  void _onAuthenticationInit(
      AuthenticationInit event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: AuthenticationStatus.authenticating));
    await Future.delayed(const Duration(seconds: 2));
    try {
      authStreamSub =
          repository.getAuthDetailStream().listen((authenticationDetailModel) {
        add(AuthenticationStateChanged(
            authenticationDetailModel: authenticationDetailModel));
      });
    } catch (e) {
      print("error :$e");
      emit(state.copyWith(status: AuthenticationStatus.unAuthenticated));
    }
  }

  void _onAuthenticationStateChanged(AuthenticationStateChanged event,
      Emitter<AuthenticationState> emit) async {
    if (event.authenticationDetailModel.isValid!) {
      emit(state.copyWith(
          status: AuthenticationStatus.authenticated,
          user: event.authenticationDetailModel));
    } else {
      emit(state.copyWith(status: AuthenticationStatus.unAuthenticated));
    }
  }

  void _onAuthenticateWithGoogleSignIn(AuthenticateWithGoogleSignIn event,
      Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: AuthenticationStatus.authenticating));

    try {
      AuthenticationDetailModel authenticationDetailModel =
          await repository.authenticateWithGoogle();

      if (authenticationDetailModel.isValid!) {
        await repositoryFireStoreDatabase.storeUser(
            user: authenticationDetailModel);
        emit(state.copyWith(
            status: AuthenticationStatus.authenticated,
            user: authenticationDetailModel));
      } else {
        emit(state.copyWith(status: AuthenticationStatus.unAuthenticated));
      }
    } catch (e) {
      print("authenticateWithGoogle error : $e");
      emit(state.copyWith(status: AuthenticationStatus.unAuthenticated));
    }
  }

  void _onLogOut(LogOut event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: AuthenticationStatus.authenticating));
    try {
      await repository.unAuthenticate();
      // await googleSignIn.disconnect();
      // await FirebaseAuth.instance.signOut();
      emit(state.copyWith(status: AuthenticationStatus.unAuthenticated));
    } catch (e) {
      print("Log out error : $e");
    }
  }
}
