import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/errors/error_model.dart';
import '../../../../core/errors/error_text.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget CustomSignupTextfield({
  required TextEditingController controller,
  required String text,
  required String error,
  required BuildContext context,
  ErrorModel? errorModel,
  bool isHidden = false,
  bool unlimitedLines = false,
  bool expand = false,
  bool acceptOnlyNumbers = false,
  bool isEnabled = true,
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
      SizedBox(
        height: expand ? calculateFontSize(context, 160) : null,
        child: TextField(
          enabled: isEnabled,
          inputFormatters:
              acceptOnlyNumbers ? [FilteringTextInputFormatter.digitsOnly] : [],
          keyboardType: acceptOnlyNumbers ? TextInputType.number : null,
          textAlignVertical: TextAlignVertical.top,
          maxLines: unlimitedLines ? null : 1,
          expands: expand ? true : false,
          controller: controller,
          obscureText: isHidden,
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
              borderSide:
                  BorderSide(color: ColorsConst.primaryColor, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide:
                  BorderSide(color: ColorsConst.primaryColor, width: 2.0),
            ),
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
