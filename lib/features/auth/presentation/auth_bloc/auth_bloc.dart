// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:new_bloc_ihu/features/signup/data/repositories/signup_repositories_impl.dart';

import '../../../login/data/repositories/login_repositories_impl.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repositories_impl.dart';
import '../../domain/usecases/completed_account_percentage.dart';
import '../../domain/usecases/secure_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoriesImpl authRepo;
  final LoginRepositoriesImpl loginRepo;
  final SignupRepositoriesImpl signupRepo;
  final storage = SecureStorage();

  AuthBloc({
    required this.authRepo,
    required this.loginRepo,
    required this.signupRepo,
  }) : super(AuthUninitialized()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<SignedUp>(_onSignedUp);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
    on<UserUpdated>(_onUserUpdated);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    String? token = await storage.hasToken();
    var userBox = Hive.box<UserModel>('user');

    if (token != null) {
      await authRepo.isAuthenticated(token: token);

      var completedAcc = competedAccountPercentage(authRepo.user!);

      if (authRepo.user == null) {
        emit(AuthUnauthenticated());
      } else {
        await userBox.put(
          'userModel',
          UserModel(
            role: authRepo.user!.role,
            username: authRepo.user!.username,
            first_name: authRepo.user!.first_name,
            last_name: authRepo.user!.last_name,
            email: authRepo.user!.email,
            major_id: authRepo.user!.major_id,
            complete: completedAcc,
          ),
        );

        if (authRepo.user!.major_id == null &&
            (authRepo.user!.role == 'user' ||
                authRepo.user!.role == 'old_student')) {
          emit(AuthUniversity());
        } else {
          emit(AuthAuthenticated(user: authRepo.user));
        }
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    var userBox = Hive.box<UserModel>('user');

    var user = loginRepo.user;

    var completedAcc = competedAccountPercentage(user!);

    await userBox.put(
      'userModel',
      UserModel(
        role: user.role,
        username: user.username,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        major_id: user.major_id,
        complete: completedAcc,
      ),
    );

    if (user.major_id == null &&
        (user.role == 'user' || user.role == 'old_student')) {
      emit(AuthUniversity());
    } else {
      emit(AuthAuthenticated(user: user));
    }
  }

  Future<void> _onSignedUp(SignedUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    var userBox = Hive.box<UserModel>('user');

    var user = signupRepo.user;

    var completedAcc = competedAccountPercentage(user!);

    await userBox.put(
      'userModel',
      UserModel(
        role: user.role,
        username: user.username,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        major_id: user.major_id,
        complete: completedAcc,
      ),
    );

    if (user.major_id == null &&
        (user.role == 'user' || user.role == 'old_student')) {
      emit(AuthUniversity());
    } else {
      emit(AuthAuthenticated(user: user));
    }
  }

  void _onLogoutButtonPressed(
      LogoutButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    var userBox = Hive.box<UserModel>('user');

    String? token = await storage.hasToken();

    await authRepo.logout(token: token!);

    await userBox.clear();
    await userBox.close();
    await storage.deleteToken();

    emit(AuthUnauthenticated());
  }

  void _onUserUpdated(UserUpdated event, Emitter<AuthState> emit) async {
    var userBox = Hive.box<UserModel>('user');

    authRepo.updateUser(event.user);

    var completedAcc = competedAccountPercentage(authRepo.user!);

    await userBox.put(
      'userModel',
      UserModel(
        role: authRepo.user!.role,
        username: authRepo.user!.username,
        first_name: authRepo.user!.first_name,
        last_name: authRepo.user!.last_name,
        email: authRepo.user!.email,
        major_id: authRepo.user!.major_id,
        complete: completedAcc,
      ),
    );

    emit(AuthAuthenticated(user: authRepo.user));
  }
}
