// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/styles.dart';
import '../../core/utils/breakpoints_utils.dart';
import '../../core/utils/routes_utils.dart';
import '../../features/listings/presentation/job_bloc/job_bloc.dart';
import '../theme/colors.dart';
import 'bloc/navigation_bloc.dart';
import 'custom_bottom_nav_bar_item.dart';
import 'widgets/custom_left_nav_bar_container.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  final String location;

  const ScaffoldWithNavBar({
    Key? key,
    required this.child,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = getDeviceOrientation(context);

    var page;
    var path = location;

    onNavigationButtonPressed(String page) {
      BlocProvider.of<NavigationBloc>(context).add(
        NavigationButtonPressed(
          page: page,
        ),
      );

      context.go(page);
    }

    return Scaffold(
      extendBody: true,
      body: orientation == DeviceOrientation.landscape
          ? SafeArea(
              child: Row(
                children: [
                  CustomLeftNavBarContainer(
                    context: context,
                    page: page,
                    path: path,
                    function: (value) {
                      onNavigationButtonPressed(value);
                    },
                  ),
                  const SizedBox(
                    width: gap,
                  ),
                  Expanded(
                    child: child,
                  ),
                ],
              ),
            )
          : child,
      bottomNavigationBar: orientation == DeviceOrientation.landscape
          ? null
          : Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                backgroundBlendMode: BlendMode.clear,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
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

                    return BottomNavigationBar(
                      backgroundColor: ColorsConst.primaryColor,
                      selectedItemColor: ColorsConst.white,
                      selectedFontSize: Platform.isIOS ? 6.5 : 8,
                      selectedLabelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 2,
                      ),
                      unselectedItemColor: ColorsConst.white,
                      showUnselectedLabels: false,
                      type: BottomNavigationBarType.fixed,
                      onTap: (int index) {
                        if (index == 0) {
                          page = PAGES.home.screenPath;

                          BlocProvider.of<JobBloc>(context).add(
                            GetRecentJobs(),
                          );
                        } else if (index == 1) {
                          page = PAGES.listing.screenPath;

                          BlocProvider.of<JobBloc>(context).add(
                            GetRecentJobs(),
                          );
                        } else {
                          page = PAGES.profile.screenPath;
                        }

                        if (page == path) return;

                        onNavigationButtonPressed(page);
                      },
                      currentIndex: state is NavigationHome
                          ? 0
                          : state is NavigationListings
                              ? 1
                              : 2,
                      items: tabs,
                    );
                  },
                ),
              ),
            ),
    );
  }
}
