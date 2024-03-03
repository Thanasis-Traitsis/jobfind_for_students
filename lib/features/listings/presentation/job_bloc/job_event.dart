part of 'job_bloc.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

class GetRecentJobs extends JobEvent {}

class GetSearchListing extends JobEvent {
  final String searchText;

  const GetSearchListing({
    required this.searchText,
  });

  @override
  List<Object> get props => [
        searchText,
      ];

  @override
  String toString() => 'Search Text(searchText: $searchText)';
}

class GetFilteredListing extends JobEvent {
  final String filterText;

  const GetFilteredListing({
    required this.filterText,
  });

  @override
  List<Object> get props => [
        filterText,
      ];

  @override
  String toString() => 'Filter Text(filterText: $filterText)';
}
