part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationInit extends AuthenticationEvent {}

class AuthenticateWithGoogleSignIn extends AuthenticationEvent {}

class LogOut extends AuthenticationEvent {}

class AuthenticationStateChanged extends AuthenticationEvent {
  final AuthenticationDetailModel authenticationDetailModel;

  const AuthenticationStateChanged({required this.authenticationDetailModel});

  @override
  List<Object> get props => [authenticationDetailModel];
}
