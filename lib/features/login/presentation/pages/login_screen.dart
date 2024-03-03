import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/errors/error_model.dart';
import '../../../../core/utils/breakpoints_utils.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../../core/utils/scaffold_message.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/usecases/navigate.dart';
import '../login_bloc/login_bloc.dart';
import '../widgets/containers/form_with_buttons.dart';
import '../widgets/containers/image_container.dart';

class LoginScreen extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const LoginScreen({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ErrorModel? errors;

  bool isHidden = true;
  bool isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = getDeviceOrientation(context);

    void callOnReturn() {
      setState(() {
        _usernameController.text = '';
        _passwordController.text = '';
        errors = null;
      });
    }

    onLoginButtonPressed() {
      if (!Hive.isBoxOpen('user')) Hive.openBox<UserModel>('user');

      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          body: {
            "username": _usernameController.text,
            "password": _passwordController.text,
          },
        ),
      );
    }

    onStudentSignupButtonPressed() async {
      // try {
      //   final result = await FlutterWebAuth.authenticate(
      //     url:
      //         "https://sso.ihu.gr/login?service=https%3A%2F%2Fdasta.ihu.gr/api/cas/login&gateway=true",
      //     callbackUrlScheme: "mycareer",
      //   );

      //   final String? user = Uri.parse(result).queryParameters['user'];

      //   print(user);

      //   if (user != null) {
      //     context
      //         .pushNamed(
      //       PAGES.signupOld.screenName,
      //       extra: user,
      //     )
      //         .then(
      //       (value) {
      //         callOnReturn();
      //       },
      //     );
      //   }
      // } catch (e) {
      //   print(e);
      // }
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          setState(() {
            isLoading = true;
          });
        }
        if (state is LoginFailure) {
          widget.scaffoldMessengerKey.currentState
              ?.showSnackBar(ScaffoldMessage(
            context: context,
            message: state.message,
            onTap: () {
              widget.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
            },
          ));

          setState(() {
            errors = state.errors;
            isLoading = false;
          });
        } else if (state is LoginSuccess) {
          setState(() {
            isLoading = false;
          });
          navigateToNextScreen(context, PAGES.auth.screenPath);
        }
      },
      child: Scaffold(
        body: orientation == DeviceOrientation.portrait
            ? Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ImageContainer(),
                      const SizedBox(
                        height: 50,
                      ),
                      FormWithButton(
                        username: _usernameController,
                        password: _passwordController,
                        function: onLoginButtonPressed,
                        context: context,
                        onReturn: callOnReturn,
                        errorModel: errors,
                        toggleHiddenPass: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },
                        isHidden: isHidden,
                        isLoading: isLoading,
                        studentSignUp: onStudentSignupButtonPressed,
                      ),
                    ],
                  ),
                ),
              )
            : Row(
                children: [
                  Container(
                    width: 300,
                    height: double.infinity,
                    color: ColorsConst.primaryColor,
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageContainer(isLandscape: true),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                          child: FormWithButton(
                            username: _usernameController,
                            password: _passwordController,
                            function: onLoginButtonPressed,
                            context: context,
                            onReturn: callOnReturn,
                            errorModel: errors,
                            toggleHiddenPass: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            isHidden: isHidden,
                            isLandscape: true,
                            isLoading: isLoading,
                            studentSignUp: onStudentSignupButtonPressed,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
