// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/data/repositories/auth_repositories_impl.dart';
import '../../../auth/domain/usecases/secure_storage.dart';
import '../../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../../data/repositories/profile_repositories_impl.dart';

part 'resume_event.dart';
part 'resume_state.dart';

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  final ProfileRepositoriesImpl profileRepositoriesImpl;
  final AuthBloc authBloc;
  final AuthRepositoriesImpl authRepo;

  final storage = SecureStorage();

  ResumeBloc({
    required this.profileRepositoriesImpl,
    required this.authBloc,
    required this.authRepo,
  }) : super(ResumeInitial()) {
    on<UploadResumeButtonPressed>(_onUploadResumeButtonPressed);
    on<InitialResumeState>(_onInitialResumeState);
  }

  void _onUploadResumeButtonPressed(
      UploadResumeButtonPressed event, Emitter<ResumeState> emit) async {
    emit(ResumeLoading());

    String? token = await storage.hasToken();

    var result = await profileRepositoriesImpl.uploadResume(
      token: token!,
      resume: event.resume,
    );

    if (result != null) {
      await authRepo.isAuthenticated(token: token);

      authBloc.add(
        UserUpdated(
          user: authRepo.user!,
        ),
      );

      emit(
        ResumeSuccess(
          message: 'Το βιογραφικό σας σημείωμα ανέβηκε με επιτυχία.',
          resume: authRepo.user!.resume_path!,
        ),
      );
    } else {
      emit(
        const ResumeFailure(
          message: 'Το βιογραφικό σας σημείωμα δεν ανέβηκε με επιτυχία',
        ),
      );
    }
  }

  void _onInitialResumeState(
      InitialResumeState event, Emitter<ResumeState> emit) async {
    emit(ResumeInitial());
  }
}
