// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupButtonPressed extends SignupEvent {
  final Map body;

  const SignupButtonPressed({
    required this.body,
  });

  @override
  List<Object> get props => [body];

  @override
  String toString() => 'SignupButtonPressed(Body: $body)';
}
