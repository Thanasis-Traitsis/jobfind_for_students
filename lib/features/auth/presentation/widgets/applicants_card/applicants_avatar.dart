import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/usecases/calculate_font_size.dart';

Widget ApplicantsAvatar({
  required BuildContext context,
  required String? imageLink,
  required String lastNameLetter,
  required String firstNameLetter,
}) {
  return Container(
    height: calculateFontSize(context, 65),
    width: calculateFontSize(context, 65),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
      color: ColorsConst.primaryColor,
    ),
    child: imageLink != null && imageLink != ''
        ? ClipRRect(
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
            child: CachedNetworkImage(
              key: UniqueKey(),
              imageUrl: publicUrl + imageLink,
              fit: BoxFit.cover,
            ),
          )
        : Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lastNameLetter,
                  style: TextStyle(
                    color: ColorsConst.white,
                    fontSize: calculateFontSize(
                      context,
                      veryLargeText,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  firstNameLetter,
                  style: TextStyle(
                    color: ColorsConst.white,
                    fontSize: calculateFontSize(
                      context,
                      veryLargeText,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
  );
}
