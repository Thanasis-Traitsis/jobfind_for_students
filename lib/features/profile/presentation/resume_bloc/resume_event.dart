part of 'resume_bloc.dart';

abstract class ResumeEvent extends Equatable {
  const ResumeEvent();

  @override
  List<Object> get props => [];
}

class UploadResumeButtonPressed extends ResumeEvent {
  final File resume;

  const UploadResumeButtonPressed({
    required this.resume,
  });

  @override
  List<Object> get props => [
        resume,
      ];

  @override
  String toString() => 'Upload Resume Button Pressed (Resume: $resume)';
}

class InitialResumeState extends ResumeEvent {}
