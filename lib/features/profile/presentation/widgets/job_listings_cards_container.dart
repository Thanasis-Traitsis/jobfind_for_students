import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../listings/presentation/job_bloc/job_bloc.dart';
import 'profile_page_card.dart';

Widget JobListingsCardsContainer({
  required BuildContext context,
  required bool isCompany,
}) {
  return Column(
    children: [
      isCompany
          ? Container()
          : ProfilePageCard(
              context: context,
              text: 'Αγαπημένες Αγγελίες',
              color: ColorsConst.highlightColor,
              icon: FontAwesomeIcons.heart,
              onTap: () {
                context.push(PAGES.favourite.screenPath).then((_) {
                  BlocProvider.of<JobBloc>(context).add(
                    GetRecentJobs(),
                  );
                });
              },
            ),
      const SizedBox(
        height: gap / 3,
      ),
      ProfilePageCard(
        context: context,
        text: isCompany ? 'Οι Αγγελίες Μου' : 'Οι Αιτήσεις Μου',
        color: ColorsConst.highlightColor,
        icon: FontAwesomeIcons.briefcase,
        onTap: () {
          context.push(PAGES.userListings.screenPath);
        },
      ),
    ],
  );
}
