part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationButtonPressed extends NavigationEvent {
  final String page;

  const NavigationButtonPressed({required this.page});

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'NavigationButtonPressed(page: $page)';
}
