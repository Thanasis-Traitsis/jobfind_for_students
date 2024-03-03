import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/usecases/calculate_font_size.dart';
import 'company_logo_container.dart';

Widget BigCardHeader({
  required BuildContext context,
  required String? imgUrl,
  required String jobTitle,
  required String company,
  required bool isFavorite,
  required Function function,
  bool isCompany = false,
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
                        largeText,
                      ),
                    ),
                  ),
                  Text(
                    company,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: calculateFontSize(
                        context,
                        mediumText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      isCompany
          ? Container()
          : !isFavorite
              ? InkWell(
                  onTap: () {
                    function();
                  },
                  child: Icon(
                    FontAwesomeIcons.heart,
                    color: ColorsConst.darkgreyColor,
                    size: calculateFontSize(
                      context,
                      30,
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
                      30,
                    ),
                  ),
                ),
    ],
  );
}
