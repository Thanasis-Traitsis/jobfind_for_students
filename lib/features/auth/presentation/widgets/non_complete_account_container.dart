import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles.dart';
import '../../../favourite/presentation/favourite_bloc/favourite_bloc.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/boolean_is_company.dart';
import '../auth_bloc/auth_bloc.dart';
import 'complete_account/complete_account_container.dart';
import 'header_row_container.dart';
import 'recent_jobs_header.dart';
import 'welcome_text_container.dart';

Widget NonCompleteAccountContainer({
  required BuildContext context,
  required UserModel user,
  required int favouriteListLength,
  required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  required VoidCallback onTap,
}) {
  return CustomScrollView(
    slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          children: [
            BlocConsumer<FavouriteBloc, FavouriteState>(
              listener: (context, state) {
                if (state is FavouriteNotEmpty) {
                  favouriteListLength = state.favJobs.length;
                }
                if (state is FavouriteEmpty) {
                  favouriteListLength = 0;
                }
              },
              builder: (context, state) {
                return HeaderRowContainer(
                  context: context,
                  hasFav: state is FavouriteNotEmpty ? state.favJobs : [],
                  hideFavIcon: booleanIsCompany(user.role),
                );
              },
            ),
            const SizedBox(
              height: gap * 2,
            ),
            WelcomeTextContainer(
              context: context,
              user: user,
              scaffoldMessengerKey: scaffoldMessengerKey,
            ),
            const SizedBox(
              height: gap,
            ),
            RecentJobsHeader(
              context: context,
              onTap: onTap,
              role: user.role!,
            ),
            const SizedBox(
              height: gap / 2,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return CompleteAccountContainer(
                  context: context,
                  scaffoldMessengerKey: scaffoldMessengerKey,
                  completedProfileStep: user.complete!['profile'],
                  completedResume: state is AuthAuthenticated
                      ? state.user!.resume_path != null &&
                          state.user!.resume_path != ''
                      : false,
                  completedImage: state is AuthAuthenticated
                      ? state.user!.avatar_path != null &&
                          state.user!.avatar_path != ''
                      : user.avatar_path != null && user.avatar_path != '',
                  completedSubmissionStep: user.complete!['submission'],
                );
              },
            ),
          ],
        ),
      ),
    ],
  );
}
