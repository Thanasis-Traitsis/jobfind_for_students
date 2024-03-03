import 'package:flutter/material.dart';

import '../../config/theme/colors.dart';
import '../constants/font_size.dart';
import '../usecases/calculate_font_size.dart';
import 'error_model.dart';

Widget ErrorText({
  required String error,
  required BuildContext context,
  ErrorModel? errorModel,
}) {
  return Container(
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
  );
}
