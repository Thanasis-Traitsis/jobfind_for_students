// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:new_bloc_ihu/features/listings/data/models/job_model.dart';
import 'package:new_bloc_ihu/features/listings/domain/usecases/translate_filter_category.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/usecases/secure_storage.dart';
import '../../data/repositories/job_repositories_impl.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepositoriesImpl jobRepo;

  final storage = SecureStorage();

  List<JobModel> jobs = [];

  List<JobModel> recomJobs = [];

  List recentApplicants = [];

  JobBloc({
    required this.jobRepo,
  }) : super(JobInitial()) {
    on<GetRecentJobs>(_onGetRecentJobs);
    on<GetSearchListing>(_onGetSearchListing);
    on<GetFilteredListing>(_onGetFilteredListing);
  }

  void _onGetRecentJobs(GetRecentJobs event, Emitter<JobState> emit) async {
    emit(JobLoading());

    UserModel? user = Hive.box<UserModel>('user').get('userModel');

    String? token = await storage.hasToken();

    jobs = await jobRepo.fetchJobs(token: token!);

    if (user!.role == 'business') {
      recentApplicants = await jobRepo.fetchApplicants(token: token);

      emit(
        JobsRecent(
          recentJobs: jobs,
          recomJobs: [],
          recentApplicants: recentApplicants,
        ),
      );
    } else {
      recomJobs = await jobRepo.fetchJobsById(user.major_id);

      emit(JobsRecent(
        recentJobs: jobs,
        recomJobs: recomJobs,
        recentApplicants: [],
      ));
    }
  }

  void _onGetSearchListing(
      GetSearchListing event, Emitter<JobState> emit) async {
    emit(JobLoading());

    List<JobModel> searchedJobs =
        await jobRepo.fetchSearchJobs(event.searchText);

    emit(
      JobsFiltered(
        filteredJobs: searchedJobs,
      ),
    );
  }

  void _onGetFilteredListing(
      GetFilteredListing event, Emitter<JobState> emit) async {
    emit(JobLoading());

    String filter = translateFilterCategory(event.filterText);

    List<JobModel> filteredJobs = await jobRepo.fetchFilterJobs(filter);

    emit(
      JobsFiltered(
        filteredJobs: filteredJobs,
      ),
    );
  }
}
