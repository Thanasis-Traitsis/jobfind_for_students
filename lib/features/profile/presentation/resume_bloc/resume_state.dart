// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'resume_bloc.dart';

abstract class ResumeState extends Equatable {
  const ResumeState();

  @override
  List<Object> get props => [];
}

class ResumeInitial extends ResumeState {}

class ResumeLoading extends ResumeState {}

class ResumeFailure extends ResumeState {
  final String message;

  const ResumeFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Resume Failure(message: $message)';
}

class ResumeSuccess extends ResumeState {
  final String message;
  final String resume;

  const ResumeSuccess({
    required this.message,
    required this.resume,
  });

  @override
  List<Object> get props => [message, resume];

  @override
  String toString() => 'Resume Success(message: $message, resume: $resume)';
}
