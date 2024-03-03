// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:new_bloc_ihu/features/auth/data/models/user_model.dart';

import '../../../../core/errors/error_model.dart';
import '../../../auth/domain/usecases/secure_storage.dart';
import '../../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../../data/repositories/profile_repositories_impl.dart';

part 'edit_account_event.dart';
part 'edit_account_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  final ProfileRepositoriesImpl profileRepositoriesImpl;
  final AuthBloc authBloc;
  final storage = SecureStorage();

  EditAccountBloc({
    required this.profileRepositoriesImpl,
    required this.authBloc,
  }) : super(EditAccountInitial()) {
    on<UpdateAccountButtonPressed>(_onEditAccountButtonPressed);
  }

  void _onEditAccountButtonPressed(
      UpdateAccountButtonPressed event, Emitter<EditAccountState> emit) async {
    emit(EditAccountLoading());

    String? token = await storage.hasToken();

    var result = await profileRepositoriesImpl.updateUser(
      body: event.body,
      id: event.id,
      token: token!,
    );

    if (result == null) {
      emit(
        EditAccountFailure(
          message: 'Η ενημέρωση λογαριασμού απέτυχε.',
          errors: profileRepositoriesImpl.errorModel,
        ),
      );
    } else {
      var userBox = Hive.box<UserModel>('user');

      await userBox.put(
        'userModel',
        UserModel(
          role: result.role,
          username: result.username,
          first_name: result.first_name,
          last_name: result.last_name,
          email: result.email,
          major_id: result.major_id,
        ),
      );

      authBloc.add(
        UserUpdated(
          user: result,
        ),
      );

      emit(
        const EditAccountSuccess(
          message: 'Τα στοιχεία του λογαριασμού σας ενημερώθηκαν επιτυχώς.',
        ),
      );
    }
  }
}
