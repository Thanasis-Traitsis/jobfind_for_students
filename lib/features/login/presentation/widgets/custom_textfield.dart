import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/errors/error_model.dart';
import '../../../../core/errors/error_text.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget CustomTextfield({
  required TextEditingController controller,
  required String text,
  required String error,
  required BuildContext context,
  Function? function,
  ErrorModel? errorModel,
  bool isHidden = false,
  bool isPassword = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        controller: controller,
        obscureText: isHidden,
        style: TextStyle(
            color: ColorsConst.textColor,
            fontSize: calculateFontSize(context, normalText)),
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? IconButton(
                  icon: SizedBox(
                    width: 50,
                    child: Icon(
                      !isHidden
                          ? FontAwesomeIcons.solidEyeSlash
                          : FontAwesomeIcons.solidEye,
                      color: ColorsConst.darkgreyColor,
                      size: calculateFontSize(
                        context,
                        20,
                      ),
                    ),
                  ),
                  onPressed: () {
                    function!();
                  },
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          labelText: text,
          labelStyle:
              TextStyle(fontSize: calculateFontSize(context, normalText)),
          filled: true,
          fillColor: ColorsConst.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: ColorsConst.primaryColor, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: ColorsConst.primaryColor, width: 2.0),
          ),
        ),
      ),
      ErrorText(
        context: context,
        error: error,
        errorModel: errorModel,
      ),
    ],
  );
}
