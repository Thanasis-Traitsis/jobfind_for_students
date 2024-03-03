import 'package:flutter/material.dart';

import '../../../../../core/errors/error_model.dart';
import '../../../../../core/widgets/screen_container.dart';
import '../text_between_lines.dart';
import 'buttons_container.dart';
import 'login_form_container.dart';

Widget FormWithButton({
  required TextEditingController username,
  required TextEditingController password,
  required VoidCallback function,
  required BuildContext context,
  ErrorModel? errorModel,
  bool isLandscape = false,
  required Function onReturn,
  required Function toggleHiddenPass,
  required bool isHidden,
  required bool isLoading,
  required Function studentSignUp,
}) {
  return ScreenContainer(
    child: Column(
      children: [
        LoginFormContainer(
          username: username,
          password: password,
          function: function,
          errorModel: errorModel,
          context: context,
          toggleHiddenPass: toggleHiddenPass,
          isHidden: isHidden,
          isLoading: isLoading,
        ),
        SizedBox(
          height: 70,
          child: TextBetweenLines(context),
        ),
        ButtonsContainer(
          context: context,
          onReturn: onReturn,
          studentSignUp: studentSignUp,
        ),
      ],
    ),
  );
}
