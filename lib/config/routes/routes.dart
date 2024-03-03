// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/page_transition.dart';
import '../../core/utils/routes_utils.dart';
import '../../error_screen.dart';
import '../../features/applicants_list/presentation/pages/applicants_list_screen.dart';
import '../../features/auth/presentation/pages/auth_screen.dart';
import '../../features/auth/presentation/pages/home_screen.dart';
import '../../features/auth/presentation/pages/major_id_screen.dart';
import '../../features/favourite/presentation/pages/favourite_jobs_screen.dart';
import '../../features/job_details/presentation/pages/job_details_screen.dart';
import '../../features/listings/presentation/pages/job_listing_screen.dart';
import '../../features/login/presentation/pages/login_screen.dart';
import '../../features/new_listing/presentation/pages/new_listing_screen.dart';
import '../../features/profile/presentation/pages/account_screen.dart';
import '../../features/profile/presentation/pages/profile_screen.dart';
import '../../features/profile/presentation/pages/request_degree_screen.dart';
import '../../features/signup/presentation/pages/signup_company_screen.dart';
import '../../features/signup/presentation/pages/signup_old_student_screen.dart';
import '../../features/user_listings/presentation/pages/user_listings_screen.dart';
import '../navigation_bar/scaffold_with_navbar.dart';

class AppRouter {
  final GlobalKey<NavigatorState> rootNavigatorKey;
  final GlobalKey<NavigatorState> shellNavigatorKey;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  AppRouter({
    required this.rootNavigatorKey,
    required this.shellNavigatorKey,
    required this.scaffoldMessengerKey,
  });

  late final GoRouter router = GoRouter(
    errorBuilder: (context, state) => const ErrorScreen(),
    initialLocation: '/auth',
    navigatorKey: rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(
            child: ScaffoldWithNavBar(
              location: state.uri.toString(),
              child: child,
            ),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: PAGES.home.screenPath,
            name: PAGES.home.screenName,
            builder: (context, state) => HomeScreen(
              scaffoldMessengerKey: scaffoldMessengerKey,
            ),
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: HomeScreen(
                scaffoldMessengerKey: scaffoldMessengerKey,
              ),
            ),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: PAGES.listing.screenPath,
            name: PAGES.listing.screenName,
            builder: (context, state) => JobListingScreen(
              scaffoldMessengerKey: scaffoldMessengerKey,
            ),
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: JobListingScreen(
                scaffoldMessengerKey: scaffoldMessengerKey,
              ),
            ),
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: PAGES.profile.screenPath,
            name: PAGES.profile.screenName,
            builder: (context, state) => ProfileScreen(
              scaffoldMessengerKey: scaffoldMessengerKey,
            ),
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: ProfileScreen(
                scaffoldMessengerKey: scaffoldMessengerKey,
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.auth.screenPath,
        name: PAGES.auth.screenName,
        builder: (context, state) => AuthScreen(
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.login.screenPath,
        name: PAGES.login.screenName,
        builder: (context, state) => LoginScreen(
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.signupOld.screenPath,
        name: PAGES.signupOld.screenName,
        builder: (context, state) { 
          String? username = state.extra as String?;
          return SignupOldStudentScreen(
          scaffoldMessengerKey: scaffoldMessengerKey,
          username: username,
        );}
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.signupComp.screenPath,
        name: PAGES.signupComp.screenName,
        builder: (context, state) => SignupCompanyScreen(
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.favourite.screenPath,
        name: PAGES.favourite.screenName,
        builder: (context, state) {
          return FavouriteJobsScreen(
            scaffoldMessengerKey: scaffoldMessengerKey,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.jobDetails.screenPath,
        name: PAGES.jobDetails.screenName,
        builder: (context, state) {
          List job = state.extra as List;
          return JobDetailsScreen(
            scaffoldMessengerKey: scaffoldMessengerKey,
            job: job[0],
            isCompany: job[1],
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.userListings.screenPath,
        name: PAGES.userListings.screenName,
        builder: (context, state) {
          return UserListingsScreen(
            scaffoldMessengerKey: scaffoldMessengerKey,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.applicantsList.screenPath,
        name: PAGES.applicantsList.screenName,
        builder: (context, state) {
          return ApplicantsListScreen(
            scaffoldMessengerKey: scaffoldMessengerKey,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.account.screenPath,
        name: PAGES.account.screenName,
        builder: (context, state) {
          List userBody = state.extra as List;
          return AccountScreen(
            scaffoldMessengerKey: scaffoldMessengerKey,
            userBody: userBody[0],
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.newListing.screenPath,
        name: PAGES.newListing.screenName,
        builder: (context, state) {
          List listingBody = state.extra as List;
          return NewListingScreen(
            scaffoldMessengerKey: scaffoldMessengerKey,
            listingBody: listingBody[0],
            universities: listingBody[1],
            departments: listingBody[2],
            majors: listingBody[3],
            values: listingBody[4],
            majorValues: listingBody[5],
            jobId: listingBody[6],
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.requestDegree.screenPath,
        name: PAGES.requestDegree.screenName,
        builder: (context, state) {
          List requestBody = state.extra as List;
          return RequestDegreeScreen(
            scaffoldMessengerKey: scaffoldMessengerKey,
            requestBody: requestBody[0],
            textControllerList: requestBody[1],
          );
        },
      ),
      GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: PAGES.majorId.screenPath,
          name: PAGES.majorId.screenName,
          builder: (context, state) {
            return MajorIdScreen(
              scaffoldMessengerKey: scaffoldMessengerKey,
            );
          }),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.error.screenPath,
        name: PAGES.error.screenName,
        builder: (context, state) => const ErrorScreen(),
      ),
    ],
  );
}
