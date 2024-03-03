import 'package:flutter/material.dart';

import '../../../../../core/errors/error_model.dart';
import '../custom_password_textfield.dart';
import '../custom_signup_textfield.dart';
import '../field_dropdown_button.dart';

Widget SignupOldStudentFormContainer({
  required TextEditingController username,
  required TextEditingController first_name,
  required TextEditingController last_name,
  required TextEditingController father_name,
  required TextEditingController mother_name,
  required TextEditingController email,
  required TextEditingController password,
  required TextEditingController confirm_password,
  required Function(String?) functionDropdown,
  required var list,
  required String? value,
  required BuildContext context,
  required Function toggleHiddenPass,
  required Function toggleHiddenPassConfirm,
  required bool showPassword,
  required bool showPasswordConfirm,
  ErrorModel? errorModel,
  bool isEnabled = true,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CustomSignupTextfield(
        controller: username,
        text: 'Όνομα Χρήστη',
        error: 'username',
        errorModel: errorModel,
        context: context,
        isEnabled: isEnabled,
      ),
      CustomSignupTextfield(
        controller: first_name,
        text: 'Όνομα',
        error: 'first_name',
        errorModel: errorModel,
        context: context,
      ),
      CustomSignupTextfield(
        controller: last_name,
        text: 'Επώνυμο',
        error: 'last_name',
        errorModel: errorModel,
        context: context,
      ),
      CustomSignupTextfield(
        controller: father_name,
        text: 'Πατρώνυμο',
        error: 'father_name',
        errorModel: errorModel,
        context: context,
      ),
      CustomSignupTextfield(
        controller: mother_name,
        text: 'Μητρώνυμο',
        error: 'mother_name',
        errorModel: errorModel,
        context: context,
      ),
      FiedDropdownButton(
        onPressed: functionDropdown,
        list: list,
        value: value,
        error: 'gender',
        errorModel: errorModel,
        context: context,
        heading: 'Φύλο',
        placeholder: 'φύλο',
      ),
      CustomSignupTextfield(
        controller: email,
        text: 'Email',
        error: 'email',
        errorModel: errorModel,
        context: context,
      ),
      CustomPasswordTextfield(
        controller: password,
        text: 'Κωδικός Πρόσβασης',
        error: 'password',
        isHidden: showPassword,
        errorModel: errorModel,
        context: context,
        function: toggleHiddenPass,
      ),
      CustomPasswordTextfield(
        controller: confirm_password,
        text: 'Επιβεβαίωση Κωδικού Πρόσβασης',
        error: 'password_confirmation',
        errorModel: errorModel,
        isHidden: showPasswordConfirm,
        context: context,
        function: toggleHiddenPassConfirm,
      ),
    ],
  );
}
