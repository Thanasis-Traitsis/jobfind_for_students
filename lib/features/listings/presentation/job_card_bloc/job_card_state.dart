// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'job_card_bloc.dart';

abstract class JobCardState extends Equatable {
  const JobCardState();

  @override
  List<Object> get props => [];
}

class JobCardInitial extends JobCardState {}

class JobCardFavourite extends JobCardState {
  final String jobId;
  final bool isFav;

  const JobCardFavourite({
    required this.jobId,
    required this.isFav,
  });

  @override
  List<Object> get props => [
        isFav,
        jobId,
      ];

  @override
  String toString() => 'Is Favourite(isFav: $isFav)';
}

class JobCardApply extends JobCardState {
  final String jobId;
  final bool hasApplied;

  const JobCardApply({
    required this.jobId,
    required this.hasApplied,
  });

  @override
  List<Object> get props => [
        hasApplied,
        jobId,
      ];

  @override
  String toString() => 'Has Applied (hasApplied: $hasApplied)';
}

class JobCardViewed extends JobCardState {
  final String jobId;
  final int views;
  final bool hasViewed;

  const JobCardViewed({
    required this.jobId,
    required this.views,
    required this.hasViewed,
  });

  @override
  List<Object> get props => [
        hasViewed,
        jobId,
      ];

  @override
  String toString() => 'Has Viewed (hasViewed: $hasViewed)';
}
