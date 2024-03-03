part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteEmpty extends FavouriteState {}

class FavouriteNotEmpty extends FavouriteState {
  final List<JobModel> favJobs;

  const FavouriteNotEmpty({
    required this.favJobs,
  });

  @override
  List<Object> get props => [favJobs];

  @override
  String toString() => 'Favourite Jobs(favJobs: $favJobs)';
}
