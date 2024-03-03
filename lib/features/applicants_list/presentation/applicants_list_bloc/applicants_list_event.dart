// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'applicants_list_bloc.dart';

abstract class ApplicantsListEvent extends Equatable {
  const ApplicantsListEvent();

  @override
  List<Object> get props => [];
}

class GetApplicantsListForThisJob extends ApplicantsListEvent {
  final String jobId;

  const GetApplicantsListForThisJob({
    required this.jobId,
  });

  @override
  List<Object> get props => [
        jobId,
      ];

  @override
  String toString() => 'GetApplicantsListForThisJob (jobId: $jobId)';
}
