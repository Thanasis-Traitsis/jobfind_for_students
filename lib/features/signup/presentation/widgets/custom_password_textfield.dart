import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/errors/error_model.dart';
import '../../../../core/errors/error_text.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget CustomPasswordTextfield({
  required TextEditingController controller,
  required String text,
  required String error,
  required BuildContext context,
  ErrorModel? errorModel,
  bool isHidden = false,
  required Function function,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.centerLeft,
        height: 30,
        child: Text(
          text,
          style: TextStyle(
            fontSize: calculateFontSize(context, normalText),
            fontWeight: FontWeight.bold,
            color: ColorsConst.primaryColor,
          ),
        ),
      ),
      TextField(
        controller: controller,
        obscureText: isHidden,
        style: TextStyle(
          color: ColorsConst.textColor,
          fontSize: calculateFontSize(context, normalText),
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
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
              function();
            },
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
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
