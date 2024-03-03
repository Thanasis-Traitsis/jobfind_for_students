// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/errors/error_model.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget DropdownButtonSelection({
  required Function(String?) onPressed,
  required list,
  required String error,
  required String heading,
  required BuildContext context,
  String? selectedValue,
  ErrorModel? errorModel,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.centerLeft,
        height: 30,
        child: Text(
          "${heading[0].toUpperCase()}${heading.substring(1).toLowerCase()}",
          style: TextStyle(
            fontSize: calculateFontSize(context, normalText),
            fontWeight: FontWeight.bold,
            color: ColorsConst.primaryColor,
          ),
        ),
      ),
      DropdownButtonFormField(
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
        value: selectedValue,
        hint: Text(
          'Επιλέξτε $heading',
          style: TextStyle(
            fontSize: calculateFontSize(context, smallText),
          ),
        ),
        onChanged: onPressed,
        isExpanded: true,
        borderRadius: BorderRadius.circular(borderRadius),
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                fontSize: calculateFontSize(context, smallText),
              ),
            ),
          );
        }).toList(),
      ),
      Container(
        margin: const EdgeInsets.only(top: 5, bottom: 10),
        child: Text(
          errorModel == null
              ? ''
              : errorModel.errors.containsKey(error)
                  ? errorModel.errors[error]![0]
                  : '',
          style: TextStyle(
            fontSize: calculateFontSize(context, smallText),
            color: ColorsConst.errorColor,
          ),
        ),
      ),
    ],
  );
}
