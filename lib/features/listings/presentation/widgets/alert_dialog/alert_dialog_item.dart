import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_font_size.dart';

Widget AlertDialogItem({
  required String text,
  required BuildContext context,
  required Function(String) function,
  bool isChosen = false,
}) {
  return GestureDetector(
    onTap: () {
      function(text);
    },
    child: Container(
      height: alertDialogItemHeight,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            isChosen ? '⬤   ' : '',
            style: TextStyle(
              fontSize: calculateFontSize(
                context,
                10,
              ),
              fontWeight: FontWeight.bold,
              color: ColorsConst.primaryColor,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: calculateFontSize(
                context,
                isChosen ? largeText : mediumText,
              ),
              fontWeight: isChosen ? FontWeight.bold : null,
              color: isChosen ? ColorsConst.primaryColor : ColorsConst.textColor,
            ),
          ),
        ],
      ),
    ),
  );
}
