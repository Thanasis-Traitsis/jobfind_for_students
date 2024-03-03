import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_font_size.dart';

Widget CheckmarkWithText({
  required BuildContext context,
  required String text,
  bool isChecked = false,
}) {
  return Container(
    margin: const EdgeInsets.only(top: gap / 2),
    child: Row(
      children: [
        Icon(
          isChecked ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.circle,
          color: isChecked ? ColorsConst.greenColor : ColorsConst.textColor,
          size: calculateFontSize(
            context,
            18,
          ),
        ),
        const SizedBox(
          width: gap / 3,
        ),
        Text(
          text,
          style: TextStyle(
            color: ColorsConst.textColor,
            fontSize: calculateFontSize(
              context,
              mediumText,
            ),
          ),
        ),
      ],
    ),
  );
}
