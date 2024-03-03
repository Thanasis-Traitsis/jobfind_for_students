import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'job_details_event.dart';
part 'job_details_state.dart';

class JobDetailsBloc extends Bloc<JobDetailsEvent, JobDetailsState> {
  JobDetailsBloc() : super(JobDetailsInitial()) {
    on<ParagraphButtonPressed>(_onParagraphButtonPressed);
  }

  void _onParagraphButtonPressed(
      ParagraphButtonPressed event, Emitter<JobDetailsState> emit) async {
    emit(JobDetailsParagraphSection(paragraph: event.section));
  }
}
