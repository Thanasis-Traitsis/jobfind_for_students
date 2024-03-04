import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/usecases/calculate_font_size.dart';

Widget CompanyLogoContainer({
  required String? imgUrl,
  required String company,
  required BuildContext context,
  bool isSmall = false,
  bool isCard = true,
}) {
  return Container(
    height: calculateFontSize(
      context,
      isCard
          ? isSmall
              ? 50
              : 60
          : 100,
    ),
    width: calculateFontSize(
      context,
      isCard
          ? isSmall
              ? 50
              : 60
          : 100,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
      color: isCard ? ColorsConst.lightgreyColor.withOpacity(.2) : ColorsConst.primaryColor.withOpacity(.2),
    ),
    alignment: Alignment.center,
    child: imgUrl == null || imgUrl == ''
        ? Text(
            company[0],
            style: TextStyle(
              color: ColorsConst.textColor,
              fontSize: calculateFontSize(
                context,
                isCard ? headerText : 36,
              ),
              fontWeight: FontWeight.bold,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
            child: CachedNetworkImage(
              key: UniqueKey(),
              // imageUrl: publicUrl + imgUrl,
              imageUrl: imgUrl,
              fit: BoxFit.cover,
            ),
          ),
  );
}
