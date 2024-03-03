// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../listings/domain/usecases/transform_date.dart';
import '../../../listings/domain/usecases/transform_employment_type.dart';
import '../../../listings/domain/usecases/transform_experience_to_String.dart';
import '../../../listings/domain/usecases/transform_isFavourite.dart';
import '../../../listings/domain/usecases/transform_views.dart';
import 'big_job_card/big_job_card.dart';
import 'small_job_card/small_job_card.dart';

class ResponsiveCard extends StatelessWidget {
  final List list;
  final int index;
  final Function toggleFav;
  final Function toggleApply;
  final Function showDetails;
  final BuildContext context;
  Function? showApplicants;
  bool isBigCard;
  bool isCompany;
  bool isMyJob;
  bool hasBottomSpacing;

  ResponsiveCard({
    Key? key,
    required this.list,
    required this.index,
    required this.toggleFav,
    required this.toggleApply,
    required this.showDetails,
    required this.context,
    this.showApplicants,
    this.isBigCard = true,
    this.isCompany = false,
    this.isMyJob = false,
    this.hasBottomSpacing = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isBigCard
        ? BigJobCard(
            isCompany: isCompany,
            context: context,
            imgUrl: list[index].avatar_path,
            jobTitle: list[index].title!,
            company: list[index].companyName!,
            city: list[index].city!,
            employmentType: transformEmploymentType(
              list[index].employmentType!,
            ),
            experience: transformExperienceToString(
              list[index].experience,
            ),
            date: transformDate(
              list[index].date!,
            ),
            views: transformViews(
              list[index].views,
            ),
            function: () {
              toggleFav();
            },
            isFavourite: transformIntToBoolean(
              list[index].isFavourite,
            ),
            isViewed: transformIntToBoolean(
              list[index].hasViewed,
            ),
            hasApplied: transformIntToBoolean(
              list[index].hasApplied,
            ),
            toggleApply: () {
              toggleApply();
            },
            showDetails: () {
              showDetails();
            },
            isMyJob: isMyJob,
            applicantsCount: list[index].applicants_count,
            showApplicants: () {
              showApplicants!();
            },
            hasBottomSpacing: hasBottomSpacing,
          )
        : SmallJobCard(
            context: context,
            imgUrl: list[index].avatar_path,
            jobTitle: list[index].title!,
            company: list[index].companyName!,
            employmentType: transformEmploymentType(
              list[index].employmentType!,
            ),
            experience: transformExperienceToString(
              list[index].experience,
            ),
            isFavourite: transformIntToBoolean(
              list[index].isFavourite,
            ),
            hasApplied: transformIntToBoolean(
              list[index].hasApplied,
            ),
            function: () {
              toggleFav();
            },
            toggleApply: () {
              toggleApply();
            },
            showDetails: () {
              showDetails();
            },
            isLast: list.length - 1 == index ? true : false,
          );
  }
}