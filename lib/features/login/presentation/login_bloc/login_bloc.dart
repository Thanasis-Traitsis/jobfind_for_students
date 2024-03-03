// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/error_model.dart';
import '../../../auth/domain/usecases/secure_storage.dart';
import '../../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../../data/repositories/login_repositories_impl.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepositoriesImpl loginRepositoriesImpl;
  final AuthBloc authBloc;
  final storage = SecureStorage();

  LoginBloc({
    required this.loginRepositoriesImpl,
    required this.authBloc,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final token = await loginRepositoriesImpl.loginUser(
        body: event.body,
      );

      if (token != null) {
        authBloc.add(LoggedIn(token: token));

        storage.persisteToken(token);

        emit(LoginSuccess());
      } else {
        emit(
          LoginFailure(
            message: 'Ανεπιτυχής σύνδεση',
            errors: loginRepositoriesImpl.errorModel,
          ),
        );
      }
    } catch (error) {
      emit(
        LoginFailure(
          message: 'Ανεπιτυχής σύνδεση',
          errors: loginRepositoriesImpl.errorModel,
        ),
      );
    }
  }
}
