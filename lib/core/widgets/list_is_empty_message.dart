import 'package:flutter/material.dart';

import '../../config/theme/colors.dart';
import '../constants/font_size.dart';
import '../usecases/calculate_font_size.dart';

Widget ListIsEmptyMessage({
  required BuildContext context,
  required String text,
}) {
  return Center(
    child: Text(
      text,
      style: TextStyle(
        fontSize: calculateFontSize(
          context,
          mediumText,
        ),
        color: ColorsConst.textColor,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
