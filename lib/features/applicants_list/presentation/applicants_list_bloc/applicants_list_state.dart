part of 'applicants_list_bloc.dart';

abstract class ApplicantsListState extends Equatable {
  const ApplicantsListState();

  @override
  List<Object> get props => [];
}

class ApplicantsListInitial extends ApplicantsListState {}

class ApplicantsListLoading extends ApplicantsListState {}

class ApplicantsListEmpty extends ApplicantsListState {}

class ApplicantsListNotEmpty extends ApplicantsListState {
  final List applicantsList;

  const ApplicantsListNotEmpty({
    required this.applicantsList,
  });

  @override
  List<Object> get props => [applicantsList];

  @override
  String toString() => 'Applicants List(applicantsList: $applicantsList)';
}
