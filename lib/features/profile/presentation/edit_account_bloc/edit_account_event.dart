// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_account_bloc.dart';

abstract class EditAccountEvent extends Equatable {
  const EditAccountEvent();

  @override
  List<Object> get props => [];
}

class UpdateAccountButtonPressed extends EditAccountEvent {
  final Map body;
  final String id;

  const UpdateAccountButtonPressed({
    required this.body,
    required this.id,
  });

  @override
  List<Object> get props => [body, id];

  @override
  String toString() => 'UpdateAccountButtonPressed(Body: $body, ID: $id)';
}
