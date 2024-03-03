// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/domain/usecases/secure_storage.dart';
import '../../data/repositories/job_card_repositories_impl.dart';

part 'job_card_event.dart';
part 'job_card_state.dart';

class JobCardBloc extends Bloc<JobCardEvent, JobCardState> {
  final JobCardRepositoriesImpl jobCardRepo;

  final storage = SecureStorage();

  JobCardBloc({
    required this.jobCardRepo,
  }) : super(JobCardInitial()) {
    on<ToggleFavouriteEvent>(_onToggleFavouriteEvent);
    on<ToggleApplyEvent>(_onToggleApplyEvent);
    on<JobDetailsButtonPressed>(_onJobDetailsButtonPressed);
  }

  void _onToggleFavouriteEvent(
    ToggleFavouriteEvent event,
    Emitter<JobCardState> emit,
  ) async {
    String? token = await storage.hasToken();

    bool isFav = await jobCardRepo.favoriteJob(
      token: token!,
      id: event.jobId,
    );

    emit(JobCardFavourite(isFav: isFav, jobId: event.jobId));
  }

  void _onToggleApplyEvent(
    ToggleApplyEvent event,
    Emitter<JobCardState> emit,
  ) async {
    String? token = await storage.hasToken();

    bool hasApplied = await jobCardRepo.applyJob(
      token: token!,
      id: event.jobId,
    );

    emit(JobCardApply(hasApplied: hasApplied, jobId: event.jobId));
  }

  void _onJobDetailsButtonPressed(
      JobDetailsButtonPressed event, Emitter<JobCardState> emit) async {
    String? token = await storage.hasToken();

    bool hasViewed = await jobCardRepo.viewJob(
      token: token!,
      id: event.jobId,
    );

     emit(JobCardViewed(hasViewed: hasViewed, jobId: event.jobId, views: event.views));
  }
}
