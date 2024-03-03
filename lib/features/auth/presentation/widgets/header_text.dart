import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget HeaderText({
  required BuildContext context,
  required String text,
}) {
  return Text(
    text,
    style: TextStyle(
      color: ColorsConst.textColor,
      fontWeight: FontWeight.bold,
      fontSize: calculateFontSize(
        context,
        headerText,
      ),
    ),
  );
}
