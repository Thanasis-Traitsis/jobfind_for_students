import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/errors/error_model.dart';
import '../../../../core/utils/breakpoints_utils.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../../core/utils/scaffold_message.dart';
import '../../../../core/widgets/highlight_color_button.dart';
import '../../../../core/widgets/screen_container.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../login/domain/usecases/navigate.dart';
import '../signup_bloc/signup_bloc.dart';
import '../widgets/already_signed_up_text.dart';
import '../widgets/containers/signup_company_form_container.dart';
import '../widgets/privacy_policy_checkbox.dart';

class SignupCompanyScreen extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const SignupCompanyScreen({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  State<SignupCompanyScreen> createState() => _SignupCompanyScreenState();
}

class _SignupCompanyScreenState extends State<SignupCompanyScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _distinctiveTitleController =
      TextEditingController();
  final TextEditingController _companyDescriptionController =
      TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _afmController = TextEditingController();
  final TextEditingController _doyController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Set the role to old_studen
  final String _role = 'business';

  // Bool variables for the privacy and policy checkbox
  bool isChecked = false;
  bool showError = false;

  // Set the errors
  ErrorModel? errors;

  // Toggle the password's visibility
  bool showPassword = true;
  bool showPasswordConfirm = true;

  bool isLoading = false;

  @override
  void initState() {
    errors = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = getDeviceOrientation(context);

    onSignupButtonPressed() {
      if (!Hive.isBoxOpen('user')) Hive.openBox<UserModel>('user');
      
      setState(() {
        showError = !isChecked;
      });

      if (!showError) {
        BlocProvider.of<SignupBloc>(context).add(
          SignupButtonPressed(
            body: {
              "username": _usernameController.text,
              "role": _role,
              "first_name": _firstNameController.text,
              "last_name": _lastNameController.text,
              "company": _companyController.text,
              "company_description": _companyDescriptionController.text,
              "distinctive_title": _distinctiveTitleController.text,
              "occupation": _occupationController.text,
              "afm": _afmController.text,
              "doy": _doyController.text,
              "address": _addressController.text,
              "city": _cityController.text,
              "postal_code": _postalCodeController.text,
              "email": _emailController.text,
              "password": _passwordController.text,
              "password_confirmation": _confirmPasswordController.text,
            },
          ),
        );
      }
    }

    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          setState(() {
            isLoading = true;
          });
        }
        if (state is SignupFailure) {
          widget.scaffoldMessengerKey.currentState?.showSnackBar(
            ScaffoldMessage(
              context: context,
              message: state.message,
              onTap: () {
                widget.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
              },
            ),
          );

          setState(() {
            errors = state.errors;
            isLoading = false;
          });
        } else if (state is SignupSuccess) {
          setState(() {
            isLoading = false;
          });
          navigateToNextScreen(context, PAGES.auth.screenPath);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Εγγραφή ως επιχείρηση'),
        ),
        body: SafeArea(
          child: ScreenContainer(
            child: Center(
              child: SizedBox(
                width: orientation == DeviceOrientation.portrait
                    ? double.infinity
                    : 500,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SignupCompanyFormContainer(
                        username: _usernameController,
                        first_name: _firstNameController,
                        last_name: _lastNameController,
                        address: _addressController,
                        afm: _afmController,
                        city: _cityController,
                        company: _companyController,
                        company_description: _companyDescriptionController,
                        distinctive_title: _distinctiveTitleController,
                        doy: _doyController,
                        occupation: _occupationController,
                        postal_code: _postalCodeController,
                        email: _emailController,
                        password: _passwordController,
                        confirm_password: _confirmPasswordController,
                        errorModel: errors,
                        context: context,
                        toggleHiddenPass: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        toggleHiddenPassConfirm: () {
                          setState(() {
                            showPasswordConfirm = !showPasswordConfirm;
                          });
                        },
                        showPassword: showPassword,
                        showPasswordConfirm: showPasswordConfirm,
                      ),
                      PrivacyPolicyCheckbox(
                        function: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                        isChecked: isChecked,
                        showError: showError,
                        context: context,
                      ),
                      AlreadySignedUpText(context: context),
                      HighlighColorButton(
                        onPressed: onSignupButtonPressed,
                        text: 'Εγγραφή',
                        context: context,
                        isLoading: isLoading,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
