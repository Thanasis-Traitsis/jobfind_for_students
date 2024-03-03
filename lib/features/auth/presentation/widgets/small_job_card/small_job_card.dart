import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/containers.dart';
import '../../../../../core/constants/styles.dart';
import '../big_job_card/icon_with_text.dart';
import 'small_card_button.dart';
import 'small_card_header.dart';

Widget SmallJobCard({
  required BuildContext context,
  required String? imgUrl,
  required String jobTitle,
  required String company,
  required String employmentType,
  required String experience,
  required Function function,
  required Function toggleApply,
  required Function showDetails,
  bool? isFavourite,
  bool hasApplied = false,
  bool isLast = false,
}) {
  return Container(
    margin: EdgeInsets.only(
      left: padding,
      right: isLast ? padding : 0,
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          showDetails();
        },
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
            border: Border.all(
              color: ColorsConst.lightgreyColor,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallCardHeader(
                context: context,
                imgUrl: imgUrl,
                jobTitle: jobTitle,
                company: company,
                isFavourite: isFavourite!,
                function: function,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconWithText(
                    context: context,
                    icon: FontAwesomeIcons.solidClock,
                    text: employmentType,
                  ),
                  IconWithText(
                    context: context,
                    icon: FontAwesomeIcons.businessTime,
                    text: experience,
                  ),
                  SmallCardButton(toggleApply, hasApplied, context),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
