import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/utils/routes_utils.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationHome()) {
    on<NavigationButtonPressed>(_onNavigationButtonPressed);
  }

  void _onNavigationButtonPressed(
      NavigationButtonPressed event, Emitter<NavigationState> emit) async {
        
    if (event.page == PAGES.profile.screenPath) {
      emit(NavigationProfile());
    } else if (event.page == PAGES.listing.screenPath) {
      emit(NavigationListings());
    } else {
      emit(NavigationHome());
    }
  }
}
