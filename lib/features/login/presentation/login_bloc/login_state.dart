// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String message;
  final ErrorModel? errors;

  const LoginFailure({
    required this.message,
    this.errors,
  });

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'LoginFailure(message: $message)';
}

class LoginSuccess extends LoginState {}
