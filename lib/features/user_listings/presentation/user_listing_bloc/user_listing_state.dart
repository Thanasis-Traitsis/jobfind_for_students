part of 'user_listing_bloc.dart';

abstract class UserListingState extends Equatable {
  const UserListingState();
  
  @override
  List<Object> get props => [];
}

class UserListingInitial extends UserListingState {}

class UserListingLoading extends UserListingState {}

class UserListingEmpty extends UserListingState {}

class UserListingNotEmpty extends UserListingState {
  final List<JobModel> userListingJobs;

  const UserListingNotEmpty({
    required this.userListingJobs,
  });

  @override
  List<Object> get props => [userListingJobs];

  @override
  String toString() => 'User Listing Jobs(userListingJobs: $userListingJobs)';
}