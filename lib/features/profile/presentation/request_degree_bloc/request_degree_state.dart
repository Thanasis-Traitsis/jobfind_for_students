part of 'request_degree_bloc.dart';

abstract class RequestDegreeState extends Equatable {
  const RequestDegreeState();

  @override
  List<Object> get props => [];
}

class RequestDegreeInitial extends RequestDegreeState {}

class RequestDegreeLoading extends RequestDegreeState {}

class RequestDegreeSuccess extends RequestDegreeState {
  final String message;

  const RequestDegreeSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'RequestDegreeSuccess(message: $message)';
}

class RequestDegreeFailure extends RequestDegreeState {
  final String message;
  final ErrorModel? errors;

  const RequestDegreeFailure({
    required this.message,
    this.errors,
  });

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'RequestDegreeFailure(message: $message)';
}
