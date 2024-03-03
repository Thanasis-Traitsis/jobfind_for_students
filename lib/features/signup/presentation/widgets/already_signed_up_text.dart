import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../login/domain/usecases/navigate.dart';

Widget AlreadySignedUpText({
  required BuildContext context,
}) {
  return SizedBox(
    height: 30,
    width: double.infinity,
    child: RichText(
      textAlign: TextAlign.end,
      text: TextSpan(
        text: 'Είστε ήδη εγγεγραμμένος;',
        style: TextStyle(
          fontFamily: 'Manrope',
          color: ColorsConst.highlightColor,
          fontWeight: FontWeight.w500,
          fontSize: smallText,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            navigateToNextScreen(
              context,
              PAGES.login.screenPath,
            );
          },
      ),
    ),
  );
}
