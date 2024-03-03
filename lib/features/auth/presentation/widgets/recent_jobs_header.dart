import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../domain/usecases/boolean_is_company.dart';
import 'header_text.dart';

Widget RecentJobsHeader({
  required BuildContext context,
  required VoidCallback onTap,
  required String role,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: padding,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        HeaderText(
          context: context,
          text: booleanIsCompany(role)
              ? 'Πρόσφατες αιτήσεις'
              : 'Πρόσφατες αγγελίες',
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: InkWell(
            onTap: onTap,
            child: Text(
              booleanIsCompany(role) ? '' : 'Δες Περισσότερες',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ColorsConst.darkgreyColor,
                fontSize: calculateFontSize(
                  context,
                  mediumText,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
