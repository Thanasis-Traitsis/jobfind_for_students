import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/domain/usecases/secure_storage.dart';
import '../../../listings/data/models/job_model.dart';
import '../../data/repositories/favourite_repositories_impl.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteRepositoriesImpl favRepo;
  final storage = SecureStorage();

  List<JobModel>? favJobs = [];

  FavouriteBloc({
    required this.favRepo,
  }) : super(FavouriteInitial()) {
    on<GetFavouriteJobs>(_onGetFavouriteJobs);
  }

  void _onGetFavouriteJobs(
      GetFavouriteJobs event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoading());

    String? token = await storage.hasToken();

    favJobs = await favRepo.getFavourites(token: token!);

    if (favJobs!.isEmpty || favJobs == null) {
      emit(FavouriteEmpty());
    } else {
      emit(FavouriteNotEmpty(
        favJobs: favJobs!,
      ));
    }
  }
}
