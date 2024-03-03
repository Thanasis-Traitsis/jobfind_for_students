part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationHome extends NavigationState {}

class NavigationListings extends NavigationState {}

class NavigationProfile extends NavigationState {}
