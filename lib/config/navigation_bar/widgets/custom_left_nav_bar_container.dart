import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/containers.dart';
import '../../../core/usecases/calculate_font_size.dart';
import '../../../core/utils/routes_utils.dart';
import '../../../features/listings/presentation/job_bloc/job_bloc.dart';
import '../../theme/colors.dart';
import '../bloc/navigation_bloc.dart';
import 'custom_left_nav_bar_item.dart';

Widget CustomLeftNavBarContainer({
  required BuildContext context,
  required String? page,
  required String path,
  required Function(String) function,
}) {
  return Container(
    margin: const EdgeInsets.only(
      top: padding,
      bottom: padding,
      left: padding,
    ),
    width: calculateFontSize(
      context,
      60,
    ),
    child: Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        backgroundBlendMode: BlendMode.clear,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is NavigationHome) {
              path = PAGES.home.screenPath;
            }
            if (state is NavigationListings) {
              path = PAGES.listing.screenPath;
            }
            if (state is NavigationProfile) {
              path = PAGES.profile.screenPath;
            }

            return BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                if (state is NavigationHome) {
                  path = PAGES.home.screenPath;
                }
                if (state is NavigationListings) {
                  path = PAGES.listing.screenPath;
                }
                if (state is NavigationProfile) {
                  path = PAGES.profile.screenPath;
                }
                return Container(
                  padding: EdgeInsets.only(
                    left: padding,
                    right: padding,
                    top: calculateFontSize(context, 20),
                    bottom: calculateFontSize(context, 10),
                  ),
                  color: ColorsConst.primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLeftNavBarItem(
                        context: context,
                        icon: FontAwesomeIcons.house,
                        isHome: true,
                        isSelected: state is NavigationHome,
                        onTap: () {
                          page = PAGES.home.screenPath;

                          BlocProvider.of<JobBloc>(context).add(
                            GetRecentJobs(),
                          );

                          if (page == path) return;

                          function(page!);
                        },
                      ),
                      CustomLeftNavBarItem(
                        context: context,
                        icon: FontAwesomeIcons.briefcase,
                        isSelected: state is NavigationListings,
                        onTap: () {
                          page = PAGES.listing.screenPath;

                          BlocProvider.of<JobBloc>(context).add(
                            GetRecentJobs(),
                          );

                          if (page == path) return;

                          function(page!);
                        },
                      ),
                      CustomLeftNavBarItem(
                        context: context,
                        icon: FontAwesomeIcons.solidUser,
                        isSelected: (state is! NavigationListings) &&
                            (state is! NavigationHome),
                        onTap: () {
                          page = PAGES.profile.screenPath;

                          if (page == path) return;

                          function(page!);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    ),
  );
}
