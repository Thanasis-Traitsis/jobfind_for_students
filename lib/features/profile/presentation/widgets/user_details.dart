import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/usecases/transform_user_icon.dart';
import '../../domain/usecases/transform_user_role.dart';

Widget UserDetails({
  required BuildContext context,
  required UserModel user,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: calculateFontSize(context, 180)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: calculateFontSize(
              context,
              10,
            ),
            vertical: calculateFontSize(
              context,
              4,
            ),
          ),
          decoration: BoxDecoration(
            color: ColorsConst.primaryColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
            border: Border.all(
              color: ColorsConst.primaryColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                transformUserIcon(user.role!),
                size: calculateFontSize(context, 20),
                color: ColorsConst.primaryColor,
              ),
              const SizedBox(
                width: gap / 2,
              ),
              Flexible(
                child: Text(
                  transformUserRole(user.role!),
                  style: TextStyle(
                    color: ColorsConst.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: calculateFontSize(
                      context,
                      largeText,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
      Text(
        '${user.last_name} ${user.first_name}',
        style: TextStyle(
          color: ColorsConst.textColor,
          fontSize: calculateFontSize(
            context,
            headerText + 2,
          ),
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
