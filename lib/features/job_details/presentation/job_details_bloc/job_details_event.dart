part of 'job_details_bloc.dart';

abstract class JobDetailsEvent extends Equatable {
  const JobDetailsEvent();

  @override
  List<Object> get props => [];
}

class ParagraphButtonPressed extends JobDetailsEvent {
  final String section;

  const ParagraphButtonPressed({required this.section});

  @override
  List<Object> get props => [section];

  @override
  String toString() => 'Section(section: $section)';
}
