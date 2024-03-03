import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../listings/data/models/job_model.dart';

Widget LocationText({
  required BuildContext context,
  required JobModel job,
}) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
          border: Border.all(
            color: ColorsConst.primaryColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.locationDot,
              color: ColorsConst.primaryColor,
              size: calculateFontSize(
                context,
                30,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: Text(
                job.city!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: calculateFontSize(
                    context,
                    mediumText,
                  ),
                  fontWeight: FontWeight.bold,
                  color: ColorsConst.primaryColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: gap / 2,
      ),
    ],
  );
}
