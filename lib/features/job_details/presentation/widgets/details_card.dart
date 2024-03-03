import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/styles.dart';
import '../../../listings/data/models/job_model.dart';
import '../../../listings/domain/usecases/transform_employment_type.dart';
import '../../../listings/domain/usecases/transform_experience_to_String.dart';
import '../../../listings/domain/usecases/transform_isFavourite.dart';
import 'details_card_header.dart';
import 'details_card_logo.dart';
import 'icon_with_text_container.dart';
import 'job_and_company_text.dart';
import 'location_text.dart';

Widget DetailsCard({
  required BuildContext context,
  required JobModel job,
}) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: padding,
          right: padding,
        ),
        padding: const EdgeInsets.all(padding),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsConst.primaryColor,
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DetailsCardHeader(
                context: context,
                date: job.date!,
                views: job.views,
                hasViewed: transformIntToBoolean(job.hasViewed)),
            DetailsCardLogo(
              context: context,
              job: job,
            ),
            JobAndCompanyText(
              context: context,
              job: job,
            ),
            LocationText(
              context: context,
              job: job,
            ),
          ],
        ),
      ),
      Container(
        padding:
            const EdgeInsets.symmetric(vertical: padding, horizontal: gap / 2),
        decoration: BoxDecoration(
          color: ColorsConst.primaryColor,
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
          border: Border.all(
            color: ColorsConst.primaryColor.withOpacity(.5),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconWithTextContainer(
              context: context,
              icon: FontAwesomeIcons.businessTime,
              text: transformExperienceToString(job.experience),
            ),
            Container(
              width: 1,
              height: 50,
              color: ColorsConst.white,
              margin: const EdgeInsets.symmetric(
                horizontal: padding,
              ),
            ),
            IconWithTextContainer(
              context: context,
              icon: FontAwesomeIcons.solidClock,
              text: transformEmploymentType(job.employmentType!),
            ),
          ],
        ),
      ),
    ],
  );
}
