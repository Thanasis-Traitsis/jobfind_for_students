import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/usecases/calculate_font_size.dart';

Widget IconWithText({
  required BuildContext context,
  required IconData icon,
  required String text,
}) {
  return Column(
    children: [
      Row(
        children: [
          Icon(
            icon,
            color: ColorsConst.darkgreyColor,
            size: calculateFontSize(context, 18),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: calculateFontSize(
                  context,
                  normalText,
                ),
                color: ColorsConst.textColor,
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}
