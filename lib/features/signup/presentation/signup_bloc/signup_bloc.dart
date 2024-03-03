// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:new_bloc_ihu/features/signup/data/repositories/signup_repositories_impl.dart';

import '../../../../core/errors/error_model.dart';
import '../../../auth/domain/usecases/secure_storage.dart';
import '../../../auth/presentation/auth_bloc/auth_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepositoriesImpl signupRepositoriesImpl;
  final AuthBloc authBloc;
  final storage = SecureStorage();

  SignupBloc({
    required this.signupRepositoriesImpl,
    required this.authBloc,
  }) : super(SignupInitial()) {
    on<SignupButtonPressed>(_onSignupButtonPressed);
  }

  void _onSignupButtonPressed(
      SignupButtonPressed event, Emitter<SignupState> emit) async {
    emit(SignupLoading());

    try {
      final token = await signupRepositoriesImpl.signupUser(
        body: event.body,
      );

      if (token != null) {
        authBloc.add(SignedUp(token: token));

        storage.persisteToken(token);

        emit(SignupSuccess());
      } else {
        emit(
          SignupFailure(
            message: 'Ανεπιτυχής δημιουργία λογαριασμού',
            errors: signupRepositoriesImpl.errorModel,
          ),
        );
      }
    } catch (error) {
      emit(
        SignupFailure(
          message: 'Ανεπιτυχής δημιουργία λογαριασμού',
          errors: signupRepositoriesImpl.errorModel,
        ),
      );
    }
  }
}
