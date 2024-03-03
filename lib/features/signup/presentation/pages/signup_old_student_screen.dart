// ignore_for_file: public_member_api_docs, sort_constructors_first
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
import '../widgets/containers/signup_old_student_form_container.dart';
import '../widgets/privacy_policy_checkbox.dart';

class SignupOldStudentScreen extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final String? username;

  const SignupOldStudentScreen({
    Key? key,
    required this.scaffoldMessengerKey,
    this.username,
  }) : super(key: key);

  @override
  State<SignupOldStudentScreen> createState() => _SignupOldStudentScreenState();
}

class _SignupOldStudentScreenState extends State<SignupOldStudentScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Set the role to old_studen
  final String _role = 'old_student';

  // Bool variables for the privacy and policy checkbox
  bool isChecked = false;
  bool showError = false;

  // Set the errors
  ErrorModel? errors;

  // Set genders as list for the dropdownbutton
  String? _gender;

  // Toggle the password's visibility
  bool showPassword = true;
  bool showPasswordConfirm = true;

  bool isLoading = false;

  var genders = [
    'Άνδρας',
    'Γυναίκα',
  ];

  String? selectedValue;

  @override
  void initState() {
    errors = null;

    _usernameController.text = widget.username != null ? widget.username! : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = getDeviceOrientation(context);

    onSignupButtonPressed() {
      if (!Hive.isBoxOpen('user')) Hive.openBox<UserModel>('user');
      if (selectedValue == 'Άνδρας') {
        _gender = 'male';
      } else if (selectedValue == 'Γυναίκα') {
        _gender = 'female';
      } else {
        _gender = '';
      }

      setState(() {
        showError = !isChecked;
      });

      if (!showError) {
        BlocProvider.of<SignupBloc>(context).add(
          SignupButtonPressed(
            body: {
              "username": _usernameController.text,
              "role": widget.username == null ? _role : 'user',
              "first_name": _firstNameController.text,
              "last_name": _lastNameController.text,
              "father_name": _fatherNameController.text,
              "mother_name": _motherNameController.text,
              "gender": _gender,
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
          title: Text(
              'Εγγραφή ως ${widget.username == null ? 'απόφοιτος' : 'φοιτητής'}'),
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
                      SignupOldStudentFormContainer(
                        isEnabled: widget.username == null,
                        username: _usernameController,
                        first_name: _firstNameController,
                        last_name: _lastNameController,
                        father_name: _fatherNameController,
                        mother_name: _motherNameController,
                        email: _emailController,
                        password: _passwordController,
                        confirm_password: _confirmPasswordController,
                        functionDropdown: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                        list: genders,
                        value: selectedValue,
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
