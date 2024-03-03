// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/containers.dart';
import '../../../../../core/constants/styles.dart';
import 'big_card_button.dart';
import 'big_card_header.dart';
import 'details_container.dart';

Widget BigJobCard({
  required BuildContext context,
  required String? imgUrl,
  required String jobTitle,
  required String company,
  required String city,
  required String employmentType,
  required String experience,
  required String date,
  required String views,
  required Function function,
  required Function toggleApply,
  required Function showDetails,
  required bool isCompany,
  Function? showApplicants,
  int? applicantsCount,
  bool? isFavourite,
  bool hasApplied = false,
  bool isViewed = false,
  bool isMyJob = false,
  bool hasBottomSpacing = true,
}) {
  return Container(
    margin: EdgeInsets.only(
      left: padding,
      right: padding,
      bottom: hasBottomSpacing ? padding : 0,
    ),
    padding: const EdgeInsets.all(padding),
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
      children: [
        BigCardHeader(
          context: context,
          imgUrl: imgUrl,
          jobTitle: jobTitle,
          company: company,
          isFavorite: isFavourite!,
          function: function,
          isCompany: isCompany,
        ),
        DetailsContainer(
          context: context,
          city: city,
          employmentType: employmentType,
          experience: experience,
          date: date,
          views: views,
          isViewed: isViewed,
        ),
        Divider(
          thickness: 1,
          color: ColorsConst.lightgreyColor,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigCardButton(
              text: 'Περισσότερα',
              showMore: true,
              function: () {
                showDetails();
              },
              context: context,
            ),
            isCompany
                ? isMyJob
                    ? BigCardButton(
                        context: context,
                        text: '$applicantsCount Αιτήσεις',
                        function: () {
                          showApplicants!();
                        },
                      )
                    : Container()
                : BigCardButton(
                    hasApplied: hasApplied,
                    text: hasApplied ? 'Ακύρωση' : 'Αίτηση',
                    function: () {
                      toggleApply();
                    },
                    context: context,
                  ),
          ],
        ),
      ],
    ),
  );
}
