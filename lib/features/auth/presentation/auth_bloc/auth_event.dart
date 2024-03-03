part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String token;

  const LoggedIn({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn(token: $token)';
}

class SignedUp extends AuthEvent {
  final String token;

  const SignedUp({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn(token: $token)';
}

class LogoutButtonPressed extends AuthEvent {}

class UserUpdated extends AuthEvent {
  final UserModel user;

  const UserUpdated({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User(user: $user)';
}
