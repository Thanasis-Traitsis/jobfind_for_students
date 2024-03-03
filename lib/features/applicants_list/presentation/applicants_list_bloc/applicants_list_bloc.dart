import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/domain/usecases/secure_storage.dart';
import '../../../user_listings/domain/repositories/user_listing_repositories.dart';

part 'applicants_list_event.dart';
part 'applicants_list_state.dart';

class ApplicantsListBloc
    extends Bloc<ApplicantsListEvent, ApplicantsListState> {
  final UserListingRepositories userListingRepo;
  final storage = SecureStorage();

  List? applicantsListing = [];

  ApplicantsListBloc({
    required this.userListingRepo,
  }) : super(ApplicantsListInitial()) {
    on<GetApplicantsListForThisJob>(_onGetApplicantsListForThisJob);
  }

  void _onGetApplicantsListForThisJob(GetApplicantsListForThisJob event,
      Emitter<ApplicantsListState> emit) async {
    emit(ApplicantsListLoading());

    String? token = await storage.hasToken();

    applicantsListing = await userListingRepo.getJobsApplicants(
      token: token!,
      jobId: event.jobId,
    );

    if (applicantsListing!.isEmpty || applicantsListing == null) {
      emit(ApplicantsListEmpty());
    } else {
      emit(ApplicantsListNotEmpty(
        applicantsList: applicantsListing!,
      ));
    }
  }
}
