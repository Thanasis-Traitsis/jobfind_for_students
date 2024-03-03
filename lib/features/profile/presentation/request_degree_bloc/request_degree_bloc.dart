// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../core/errors/error_model.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/data/repositories/auth_repositories_impl.dart';
import '../../../auth/domain/usecases/secure_storage.dart';
import '../../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../../data/repositories/profile_repositories_impl.dart';

part 'request_degree_event.dart';
part 'request_degree_state.dart';

class RequestDegreeBloc extends Bloc<RequestDegreeEvent, RequestDegreeState> {
  final ProfileRepositoriesImpl profileRepositoriesImpl;
  final AuthBloc authBloc;
  final AuthRepositoriesImpl authRepo;
  final storage = SecureStorage();

  RequestDegreeBloc({
    required this.profileRepositoriesImpl,
    required this.authBloc,
    required this.authRepo,
  }) : super(RequestDegreeInitial()) {
    on<RequestDegreeButtonPressed>(_onRequestDegreeButtonPressed);
    on<ViewSubmissionButtonPressed>(_onViewSubmissionButtonPressed);
  }

  void _onRequestDegreeButtonPressed(RequestDegreeButtonPressed event,
      Emitter<RequestDegreeState> emit) async {
    emit(RequestDegreeLoading());

    String? token = await storage.hasToken();

    var result = await profileRepositoriesImpl.submitSubmission(
      body: event.body,
      token: token!,
    );

    if (result == null) {
      emit(
        RequestDegreeFailure(
          message: 'Η αίτηση πτυχίου απέτυχε.',
          errors: profileRepositoriesImpl.errorModel,
        ),
      );
    } else {
      await authRepo.isAuthenticated(token: token);

      authBloc.add(
        UserUpdated(
          user: authRepo.user!,
        ),
      );

      emit(
        const RequestDegreeSuccess(
          message:
              'Η αίτηση πτυχίου δημιουργήθηκε επιτυχώς. Εκκρεμεί η απόφαση της γραμματείας.',
        ),
      );
    }
  }

  void _onViewSubmissionButtonPressed(ViewSubmissionButtonPressed event,
      Emitter<RequestDegreeState> emit) async {
    emit(RequestDegreeLoading());

    String? token = await storage.hasToken();

    var result = await profileRepositoriesImpl.getSubmission(
      id: event.id,
      token: token!,
    );

    if (result == null) {
      emit(
        RequestDegreeFailure(
          message: 'Αδυναμία εμφάνισης της αίτησης του χρήστη.',
          errors: profileRepositoriesImpl.errorModel,
        ),
      );
    }

    emit(RequestDegreeInitial());
  }
}
