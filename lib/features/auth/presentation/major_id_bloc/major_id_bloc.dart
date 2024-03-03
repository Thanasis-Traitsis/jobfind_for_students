// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/auth_repositories_impl.dart';
import '../../domain/usecases/secure_storage.dart';

part 'major_id_event.dart';
part 'major_id_state.dart';

class MajorIdBloc extends Bloc<MajorIdEvent, MajorIdState> {
  final AuthRepositoriesImpl authRepo;
  final storage = SecureStorage();

  MajorIdBloc({
    required this.authRepo,
  }) : super(MajorIdInitial()) {
    on<SetMajorId>(_onSetMajorId);
  }

  void _onSetMajorId(SetMajorId event, Emitter<MajorIdState> emit) async {
    emit(MajorIdLoading());

    String? token = await storage.hasToken();

    var result = await authRepo.setAcademia(
      token: token!,
      majorId: event.majorId,
    );

    if (!result) {
      emit(
        const MajorIdFailure(
          message: 'Η επιλογή πανεπιστημίου απέτυχε.',
        ),
      );
    } else {
      emit(
        const MajorIdSuccess(
          message: 'Η επιλογή πανεπιστημίου πραγματοποιήθηκε επιτυχώς.',
        ),
      );
    }
  }
}
