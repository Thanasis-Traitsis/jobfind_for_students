part of 'request_degree_bloc.dart';

abstract class RequestDegreeEvent extends Equatable {
  const RequestDegreeEvent();

  @override
  List<Object> get props => [];
}

class RequestDegreeButtonPressed extends RequestDegreeEvent {
  final Map body;

  const RequestDegreeButtonPressed({
    required this.body,
  });

  @override
  List<Object> get props => [body];

  @override
  String toString() => 'RequestDegreeButtonPressed(Body: $body,)';
}

class ViewSubmissionButtonPressed extends RequestDegreeEvent {
  final String id;

  const ViewSubmissionButtonPressed({
    required this.id,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ViewSubmissionButtonPressed(Id: $id,)';
}
