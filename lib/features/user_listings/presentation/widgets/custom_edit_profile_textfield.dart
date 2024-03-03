import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/errors/error_model.dart';
import '../../../../core/errors/error_text.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget CustomEditProfileTextfield({
  required TextEditingController controller,
  required String text,
  required String error,
  required BuildContext context,
  required String initialValue,
  ErrorModel? errorModel,
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
        style: TextStyle(
          color: ColorsConst.textColor,
          fontSize: calculateFontSize(context, normalText),
        ),
        decoration: InputDecoration(
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
