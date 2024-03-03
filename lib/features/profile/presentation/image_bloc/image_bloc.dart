// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/data/repositories/auth_repositories_impl.dart';
import '../../../auth/domain/usecases/secure_storage.dart';
import '../../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../../data/repositories/profile_repositories_impl.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ProfileRepositoriesImpl profileRepositoriesImpl;
  final AuthRepositoriesImpl authRepo;
  final AuthBloc authBloc;
  final storage = SecureStorage();

  ImageBloc({
    required this.profileRepositoriesImpl,
    required this.authRepo,
    required this.authBloc,
  }) : super(ImageInitial()) {
    on<UploadImageButtonPressed>(_onUploadImageButtonPressed);
  }

  void _onUploadImageButtonPressed(
      UploadImageButtonPressed event, Emitter<ImageState> emit) async {
    emit(ImageLoading());

    String? token = await storage.hasToken();

    var result = await profileRepositoriesImpl.uploadImage(
      token: token!,
      image: event.image,
    );

    if (result != null) {
      await authRepo.isAuthenticated(token: token);

      authBloc.add(
        UserUpdated(
          user: authRepo.user!,
        ),
      );

      emit(
        ImageSuccess(
          message: 'Η φωτογραφία σας ενημερώθηκε με επιτυχία.',
          image: authRepo.user!.avatar_path!,
        ),
      );
    } else {
      emit(
        const ImageFailure(
          message: 'Σφάλμα κατά την ενημέρωση της φωτογραφίας σας.',
        ),
      );
    }
  }
}
