part of 'major_id_bloc.dart';

abstract class MajorIdEvent extends Equatable {
  const MajorIdEvent();

  @override
  List<Object> get props => [];
}

class SetMajorId extends MajorIdEvent {
  final String majorId;

  const SetMajorId({required this.majorId});

  @override
  List<Object> get props => [majorId];

  @override
  String toString() => 'majorId(majorId: $majorId)';
}
