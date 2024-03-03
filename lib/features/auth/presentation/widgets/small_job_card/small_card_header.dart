import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/usecases/calculate_font_size.dart';
import '../big_job_card/company_logo_container.dart';

Widget SmallCardHeader({
  required BuildContext context,
  required String? imgUrl,
  required String jobTitle,
  required String company,
  required bool isFavourite,
  required Function function,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flexible(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CompanyLogoContainer(
              company: company,
              context: context,
              imgUrl: imgUrl,
              isSmall: true,
            ),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobTitle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: calculateFontSize(
                        context,
                        mediumText,
                      ),
                    ),
                  ),
                  Text(
                    company,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: calculateFontSize(
                        context,
                        normalText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      !isFavourite
          ? InkWell(
              onTap: () {
                function();
              },
              child: Icon(
                FontAwesomeIcons.heart,
                color: ColorsConst.darkgreyColor,
                size: calculateFontSize(
                  context,
                  25,
                ),
              ),
            )
          : InkWell(
              onTap: () {
                function();
              },
              child: Icon(
                FontAwesomeIcons.solidHeart,
                color: ColorsConst.secondHighlightColor,
                size: calculateFontSize(
                  context,
                  25,
                ),
              ),
            ),
    ],
  );
}
