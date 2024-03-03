part of 'new_listing_bloc.dart';

abstract class NewListingState extends Equatable {
  const NewListingState();
  
  @override
  List<Object> get props => [];
}

class NewListingInitial extends NewListingState {}

class NewListingLoading extends NewListingState {}

class NewListingSuccess extends NewListingState {
  final String message;

  const NewListingSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'NewListingSuccess(message: $message)';
}

class NewListingFailure extends NewListingState {
  final String message;
  final ErrorModel? errors;

  const NewListingFailure({
    required this.message,
    this.errors,
  });

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'NewListingFailure(message: $message)';
}
