// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final Map body;

  const LoginButtonPressed({required this.body});

  @override
  List<Object> get props => [body];

  @override
  String toString() => 'LoginButtonPressed(Body: $body)';
}
