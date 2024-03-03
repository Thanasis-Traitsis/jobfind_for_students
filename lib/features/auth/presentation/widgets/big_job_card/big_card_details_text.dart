import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/usecases/calculate_font_size.dart';

Widget BigCardDetailsText({
  required BuildContext context,
  required String label,
  required String text,
}) {
  return Row(
    children: [
      Text(
        '$label :',
        style: TextStyle(
          fontSize: calculateFontSize(context, mediumText),
          color: ColorsConst.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      Flexible(
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: calculateFontSize(context, mediumText),
            color: ColorsConst.textColor,
          ),
        ),
      )
    ],
  );
}
