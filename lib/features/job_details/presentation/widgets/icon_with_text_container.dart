import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget IconWithTextContainer({
  required BuildContext context,
  required IconData icon,
  required String text,
}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: ColorsConst.white,
          size: calculateFontSize(
            context,
            20,
          ),
        ),
        const SizedBox(
          height: gap,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: calculateFontSize(
              context,
              mediumText,
            ),
            fontWeight: FontWeight.bold,
            color: ColorsConst.white,
          ),
        ),
      ],
    ),
  );
}
