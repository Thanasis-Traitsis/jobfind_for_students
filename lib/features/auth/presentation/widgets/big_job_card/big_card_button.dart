import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/usecases/calculate_font_size.dart';

Widget BigCardButton({
  required BuildContext context,
  required String text,
  required Function function,
  bool hasApplied = false,
  bool showMore = false,
}) {
  return SizedBox(
    height: 40,
    width: 140,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        backgroundColor: showMore
            ? ColorsConst.darkgreyColor
            : hasApplied
                ? ColorsConst.secondHighlightColor
                : ColorsConst.highlightColor,
      ),
      onPressed: () {
        function();
      },
      child: Text(
        text,
        style: TextStyle(
          color: ColorsConst.white,
          fontSize: calculateFontSize(context, mediumText)
        ),
      ),
    ),
  );
}
