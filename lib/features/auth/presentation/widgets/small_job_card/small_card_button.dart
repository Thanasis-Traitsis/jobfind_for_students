import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/usecases/calculate_font_size.dart';

Widget SmallCardButton(Function toggleApply, bool hasApplied, BuildContext context) {
  return SizedBox(
    height: 30,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        backgroundColor:
            hasApplied ? ColorsConst.secondHighlightColor : ColorsConst.highlightColor,
      ),
      onPressed: () {
        toggleApply();
      },
      child: Text(
        hasApplied ? 'Ακύρωση Αίτησης' :'Αίτηση',
        style: TextStyle(
          color: ColorsConst.white,
          fontSize: calculateFontSize(context, mediumText)
        ),
      ),
    ),
  );
}
