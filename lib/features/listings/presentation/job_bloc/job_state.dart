// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'job_bloc.dart';

abstract class JobState extends Equatable {
  const JobState();

  @override
  List<Object> get props => [];
}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobsRecent extends JobState {
  final List<JobModel> recentJobs;
  final List<JobModel> recomJobs;
  final List recentApplicants;

  const JobsRecent({
    required this.recentJobs,
    required this.recomJobs,
    required this.recentApplicants,
  });

  @override
  List<Object> get props => [recentJobs, recomJobs, recentApplicants,];

  @override
  String toString() =>
      'Recent Jobs(recentJobs: $recentJobs, recomJobs: $recomJobs, recentApplicants: $recentApplicants)';
}

class JobsFiltered extends JobState {
  final List<JobModel> filteredJobs;

  const JobsFiltered({
    required this.filteredJobs,
  });

  @override
  List<Object> get props => [
        filteredJobs,
      ];

  @override
  String toString() => 'Filtered Jobs(filteredJobs: $filteredJobs,)';
}

class JobFetchAll extends JobState {}
