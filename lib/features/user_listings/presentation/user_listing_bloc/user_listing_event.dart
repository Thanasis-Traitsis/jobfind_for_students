part of 'user_listing_bloc.dart';

abstract class UserListingEvent extends Equatable {
  const UserListingEvent();

  @override
  List<Object> get props => [];
}

class GetUserListingsJobs extends UserListingEvent {
  final bool isCompany;

  const GetUserListingsJobs({
    required this.isCompany,
  });

  @override
  List<Object> get props => [
        isCompany,
      ];

  @override
  String toString() => 'GetUserListingsJobs (isCompany: $isCompany)';
}
