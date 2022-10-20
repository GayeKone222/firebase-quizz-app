part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticating, authenticated, unAuthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final AuthenticationDetailModel? user;

  const AuthenticationState({
    this.status = AuthenticationStatus.authenticating,
    this.user
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    AuthenticationDetailModel? user
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user
    );
  }

  @override
  List<Object?> get props => [status, user];
}
