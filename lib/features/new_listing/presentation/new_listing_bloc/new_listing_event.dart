// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'new_listing_bloc.dart';

abstract class NewListingEvent extends Equatable {
  const NewListingEvent();

  @override
  List<Object> get props => [];
}

class CreateListingButtonPressed extends NewListingEvent {
  final Map body;

  const CreateListingButtonPressed({
    required this.body,
  });

  @override
  List<Object> get props => [
        body,
      ];

  @override
  String toString() => 'UpdateAccountButtonPressed(Body: $body,)';
}

class UpdateListingButtonPressed extends NewListingEvent {
  final Map body;
  final String id;

  const UpdateListingButtonPressed({
    required this.body,
    required this.id,
  });

  @override
  List<Object> get props => [
        body,
        id,
      ];

  @override
  String toString() => 'UpdateAccountButtonPressed(Body: $body, JobId: $id)';
}

class DeleteListingButtonPressed extends NewListingEvent {
  final String id;

  const DeleteListingButtonPressed({
    required this.id,
  });

  @override
  List<Object> get props => [
        id,
      ];

  @override
  String toString() => 'UpdateAccountButtonPressed(JobId: $id)';
}
