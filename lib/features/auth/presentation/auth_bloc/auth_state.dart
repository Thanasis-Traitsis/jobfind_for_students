part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthUninitialized extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel? user;

  const AuthAuthenticated({
    required this.user,
  });

  @override
  List<Object> get props => [user!];

  @override
  String toString() => 'Authenticated User(user: $user)';
}

class AuthUnauthenticated extends AuthState {}

class AuthUniversity extends AuthState {}

class AuthLoading extends AuthState {}
