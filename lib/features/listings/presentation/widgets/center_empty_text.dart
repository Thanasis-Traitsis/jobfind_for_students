import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget CenterEmptyText({
  required BuildContext context,
  required String text,
  bool refreshButton = false,
}) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: padding,
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: calculateFontSize(
                  context,
                  mediumText,
                ),
                fontWeight: FontWeight.bold,
                color: ColorsConst.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
