import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/usecases/calculate_font_size.dart';

Widget IconWithText({
  required BuildContext context,
  required IconData icon,
  required String text,
  bool isExpanded = false,
  bool isWhite = false,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Icon(
          icon,
          size: calculateFontSize(context, 20),
          color: isWhite ? ColorsConst.white : ColorsConst.darkgreyColor,
        ),
        const SizedBox(
          width: 10,
        ),
        isExpanded
            ? Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: calculateFontSize(
                      context,
                      mediumText,
                    ),
                    color: isWhite ? ColorsConst.white : ColorsConst.textColor,
                  ),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: calculateFontSize(
                    context,
                    mediumText,
                  ),
                  color: isWhite ? ColorsConst.white : ColorsConst.textColor,
                ),
              ),
      ],
    ),
  );
}
