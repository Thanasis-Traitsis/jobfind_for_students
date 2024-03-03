import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/error_model.dart';
import '../../data/repositories/new_listings_repositories_impl.dart';

part 'new_listing_event.dart';
part 'new_listing_state.dart';

class NewListingBloc extends Bloc<NewListingEvent, NewListingState> {
  final NewListingsRepositoriesImpl newListingsRepositoriesImpl;

  NewListingBloc({
    required this.newListingsRepositoriesImpl,
  }) : super(NewListingInitial()) {
    on<CreateListingButtonPressed>(_onCreateListingButtonPressed);
    on<UpdateListingButtonPressed>(_onUpdateListingButtonPressed);
    on<DeleteListingButtonPressed>(_onDeleteListingButtonPressed);
  }

  void _onCreateListingButtonPressed(
      CreateListingButtonPressed event, Emitter<NewListingState> emit) async {
    emit(NewListingLoading());

    var result = await newListingsRepositoriesImpl.createListing(
      body: event.body,
    );

    if (!result) {
      emit(
        NewListingFailure(
          message: 'Η δημιουργία αγγελίας απέτυχε.',
          errors: newListingsRepositoriesImpl.errorModel,
        ),
      );
    } else {
      emit(
        const NewListingSuccess(
          message: 'Η αγγελία δημιουργήθηκε επιτυχώς.',
        ),
      );
    }
  }

  void _onUpdateListingButtonPressed(
      UpdateListingButtonPressed event, Emitter<NewListingState> emit) async {
    emit(NewListingLoading());

    var result = await newListingsRepositoriesImpl.updateListing(
      body: event.body,
      jobId: event.id,
    );

    if (!result) {
      emit(
        NewListingFailure(
          message: 'Η ενημέρωση αγγελίας απέτυχε.',
          errors: newListingsRepositoriesImpl.errorModel,
        ),
      );
    } else {
      emit(
        const NewListingSuccess(
          message: 'Η ενημέρωση της αγγελίας πραγματοποιήθηκε επιτυχώς.',
        ),
      );
    }
  }

  void _onDeleteListingButtonPressed(
      DeleteListingButtonPressed event, Emitter<NewListingState> emit) async {
    emit(NewListingLoading());

    var result = await newListingsRepositoriesImpl.deleteListing(
      jobId: event.id,
    );

    if (!result) {
      emit(
        NewListingFailure(
          message: 'Η διαγραφή αγγελίας απέτυχε.',
          errors: newListingsRepositoriesImpl.errorModel,
        ),
      );
    } else {
      emit(
        const NewListingSuccess(
          message: 'Η διαγραφή της αγγελίας πραγματοποιήθηκε επιτυχώς.',
        ),
      );
    }
  }
}
