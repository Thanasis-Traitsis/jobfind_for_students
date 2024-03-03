part of 'major_id_bloc.dart';

abstract class MajorIdState extends Equatable {
  const MajorIdState();

  @override
  List<Object> get props => [];
}

class MajorIdInitial extends MajorIdState {}

class MajorIdLoading extends MajorIdState {}

class MajorIdSuccess extends MajorIdState {
  final String message;

  const MajorIdSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'MajorIdSuccess(message: $message)';
}

class MajorIdFailure extends MajorIdState {
  final String message;

  const MajorIdFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'MajorIdFailure(message: $message)';
}
