import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_font_size.dart';

Widget HeaderContainer({
  required BuildContext context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Μη Διαθέσιμες Αγγελίες',
        style: TextStyle(
          color: ColorsConst.textColor,
          fontSize: calculateFontSize(
            context,
            veryLargeText,
          ),
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: gap / 3),
      Text(
        'Οι πρόσφατες αγγελίες δεν είναι διαθέσιμες σε αυτόν τον λογαριασμό. Ολοκληρώστε τα παρακάτω βήματα στη σελίδα του προφίλ για να τις ενεργοποιήσετε :',
        style: TextStyle(
          color: ColorsConst.textColor,
          fontSize: calculateFontSize(
            context,
            normalText,
          ),
        ),
      ),
    ],
  );
}
