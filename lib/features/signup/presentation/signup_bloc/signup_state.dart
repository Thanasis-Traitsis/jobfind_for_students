part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();
  
  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupFailure extends SignupState {
  final String message;
  final ErrorModel? errors;

  const SignupFailure({
    required this.message,
    this.errors,
  });

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'SignupFailure(message: $message)';
}

class SignupSuccess extends SignupState {}
