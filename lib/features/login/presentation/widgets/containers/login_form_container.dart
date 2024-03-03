import 'package:flutter/material.dart';

import '../../../../../core/errors/error_model.dart';
import '../../../../../core/widgets/highlight_color_button.dart';
import '../custom_textfield.dart';

Widget LoginFormContainer({
  required TextEditingController username,
  required TextEditingController password,
  required VoidCallback function,
  required BuildContext context,
  required Function toggleHiddenPass,
  ErrorModel? errorModel,
  bool isHidden = true,
  bool isLoading = false,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CustomTextfield(
        controller: username,
        text: 'Όνομα Χρήστη',
        error: 'username',
        errorModel: errorModel,
        context: context,
      ),
      CustomTextfield(
        isPassword: true,
        controller: password,
        text: 'Κωδικός Πρόσβασης',
        error: 'password',
        isHidden: isHidden,
        errorModel: errorModel,
        context: context,
        function: toggleHiddenPass,
      ),
      // SizedBox(
      //   height: 30,
      //   width: double.infinity,
      //   child: RichText(
      //     textAlign: TextAlign.end,
      //     text: TextSpan(
      //       text: 'Ξεχάσατε τον κωδικό σας;',
      //       style: TextStyle(
      //         fontFamily: 'Manrope',
      //         color: ColorsConst.highlightColor,
      //         fontWeight: FontWeight.w500,
      //         fontSize: smallText,
      //       ),
      //       recognizer: TapGestureRecognizer()
      //         ..onTap = () {
      //           print('yes');
      //         },
      //     ),
      //   ),
      // ),
      HighlighColorButton(
        onPressed: function,
        text: 'Σύνδεση',
        context: context,
        isLoading: isLoading,
      ),
    ],
  );
}
