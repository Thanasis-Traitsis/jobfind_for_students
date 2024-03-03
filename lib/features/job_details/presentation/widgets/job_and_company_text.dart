import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../listings/data/models/job_model.dart';

Widget JobAndCompanyText({
  required BuildContext context,
  required JobModel job,
}) {
  return Column(
    children: [
      Text(
        job.title!,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: calculateFontSize(
            context,
            largeText,
          ),
          color: ColorsConst.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: gap / 2,
      ),
      Text(
        job.companyName!,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: calculateFontSize(
            context,
            mediumText,
          ),
          color: ColorsConst.textColor,
        ),
      ),
      const SizedBox(
        height: gap,
      ),
    ],
  );
}
