import 'package:flutter/material.dart';

import '../../../../../core/errors/error_model.dart';
import '../custom_password_textfield.dart';
import '../custom_signup_textfield.dart';

Widget SignupCompanyFormContainer({
  required BuildContext context,
  required TextEditingController username,
  required TextEditingController first_name,
  required TextEditingController last_name,
  required TextEditingController company,
  required TextEditingController company_description,
  required TextEditingController distinctive_title,
  required TextEditingController occupation,
  required TextEditingController afm,
  required TextEditingController doy,
  required TextEditingController address,
  required TextEditingController city,
  required TextEditingController postal_code,
  required TextEditingController email,
  required TextEditingController password,
  required TextEditingController confirm_password,
  required Function toggleHiddenPass,
  required Function toggleHiddenPassConfirm,
  required bool showPassword,
  required bool showPasswordConfirm,
  ErrorModel? errorModel,
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
        controller: company,
        text: 'Επωνυμία',
        error: 'company',
        errorModel: errorModel,
        context: context,
      ),
      CustomSignupTextfield(
        controller: distinctive_title,
        text: 'Διακριτικός Τίτλος',
        error: 'distinctive_title',
        errorModel: errorModel,
        context: context,
      ),
      CustomSignupTextfield(
        controller: company_description,
        text: 'Περιγραφή Εταιρείας',
        error: 'company_description',
        errorModel: errorModel,
        context: context,
      ),
      CustomSignupTextfield(
        controller: occupation,
        text: 'Επάγγελμα',
        error: 'occupation',
        errorModel: errorModel,
        context: context,
      ),
      CustomSignupTextfield(
        controller: address,
        text: 'Διεύθυνση',
        error: 'address',
        errorModel: errorModel,
        context: context,
      ),
      CustomSignupTextfield(
        controller: city,
        text: 'Πόλη',
        error: 'city',
        errorModel: errorModel,
        context: context,
      ),
      CustomSignupTextfield(
        controller: postal_code,
        text: 'Ταχυδρομικός Κώδικας',
        error: 'postal_code',
        errorModel: errorModel,
        context: context,
      ),
      CustomSignupTextfield(
        controller: afm,
        text: 'Α.Φ.Μ.',
        error: 'afm',
        errorModel: errorModel,
        context: context,
      ),
      CustomSignupTextfield(
        controller: doy,
        text: 'Δ.Ο.Υ.',
        error: 'doy',
        errorModel: errorModel,
        context: context,
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