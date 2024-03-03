import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget OutlineIconButton({
  required IconData icon,
  required String text,
  required VoidCallback onPressed,
  required BuildContext context,
  bool isHighlight = false,
  bool isLandscape = false,
}) {
  return OutlinedButton.icon(
    onPressed: onPressed,
    icon: Icon(
      icon,
      color: isLandscape
          ? ColorsConst.white
          : isHighlight
              ? ColorsConst.highlightColor
              : ColorsConst.textColor.withOpacity(.7),
    ),
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: const EdgeInsets.all(10),
      side: BorderSide(
        color: isLandscape
            ? ColorsConst.white
            : isHighlight
                ? ColorsConst.highlightColor
                : ColorsConst.textColor.withOpacity(.7),
      ),
    ),
    label: Text(
      text,
      style: TextStyle(
        color: isLandscape
            ? ColorsConst.white
            : isHighlight
                ? ColorsConst.highlightColor
                : ColorsConst.textColor.withOpacity(.7),
        fontSize: calculateFontSize(context, smallText),
      ),
    ),
  );
}
