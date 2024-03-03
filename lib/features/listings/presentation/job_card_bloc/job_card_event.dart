// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'job_card_bloc.dart';

abstract class JobCardEvent extends Equatable {
  const JobCardEvent();

  @override
  List<Object> get props => [];
}

class ToggleFavouriteEvent extends JobCardEvent {
  final String jobId;

  const ToggleFavouriteEvent({
    required this.jobId,
  });

  @override
  List<Object> get props => [
        jobId,
      ];

  @override
  String toString() => 'JobId(jobId: $jobId)';
}

class ToggleApplyEvent extends JobCardEvent {
  final String jobId;

  const ToggleApplyEvent({
    required this.jobId,
  });

  @override
  List<Object> get props => [
        jobId,
      ];

  @override
  String toString() => 'JobId(jobId: $jobId)';
}

class JobDetailsButtonPressed extends JobCardEvent {
  final String jobId;
  final int views;

  const JobDetailsButtonPressed({
    required this.jobId,
    required this.views,
  });

  @override
  List<Object> get props => [
        jobId,
      ];

  @override
  String toString() => 'JobId(jobId: $jobId)';
}
