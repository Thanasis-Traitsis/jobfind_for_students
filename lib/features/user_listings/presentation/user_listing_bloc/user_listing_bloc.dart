// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:new_bloc_ihu/features/user_listings/domain/repositories/user_listing_repositories.dart';

import '../../../auth/domain/usecases/secure_storage.dart';
import '../../../listings/data/models/job_model.dart';

part 'user_listing_event.dart';
part 'user_listing_state.dart';

class UserListingBloc extends Bloc<UserListingEvent, UserListingState> {
  final UserListingRepositories userListingRepo;
  final storage = SecureStorage();

  List<JobModel>? userListingJobs = [];

  UserListingBloc({
    required this.userListingRepo,
  }) : super(UserListingInitial()) {
    on<GetUserListingsJobs>(_onGetUserListingsJobs);
  }

  void _onGetUserListingsJobs(
      GetUserListingsJobs event, Emitter<UserListingState> emit) async {
    emit(UserListingLoading());

    String? token = await storage.hasToken();

    if (event.isCompany) {
      userListingJobs = await userListingRepo.getMyJobs(token: token!);
    } else {
      userListingJobs = await userListingRepo.getAppliedJobs(token: token!);
    }

    if (userListingJobs!.isEmpty || userListingJobs == null) {
      emit(UserListingEmpty());
    } else {
      emit(UserListingNotEmpty(
        userListingJobs: userListingJobs!,
      ));
    }
  }
}
