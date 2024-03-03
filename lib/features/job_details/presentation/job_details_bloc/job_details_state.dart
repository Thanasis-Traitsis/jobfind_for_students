part of 'job_details_bloc.dart';

abstract class JobDetailsState extends Equatable {
  const JobDetailsState();

  @override
  List<Object> get props => [];
}

class JobDetailsInitial extends JobDetailsState {}

class JobDetailsParagraphSection extends JobDetailsState {
  final String paragraph;

  const JobDetailsParagraphSection({
    required this.paragraph,
  });

  @override
  List<Object> get props => [paragraph];

  @override
  String toString() => 'Paragraph(paragraph: $paragraph)';
}
