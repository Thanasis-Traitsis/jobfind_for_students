// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../config/navigation_bar/bloc/navigation_bloc.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../favourite/presentation/favourite_bloc/favourite_bloc.dart';
import '../../../listings/data/models/job_model.dart';
import '../../../listings/presentation/job_card_bloc/job_card_bloc.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/boolean_is_company.dart';
import '../widgets/home_jobs_container.dart';
import '../widgets/non_complete_account_container.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const HomeScreen({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? user = Hive.box<UserModel>('user').get('userModel');

    int favouriteListLength = 0;
    int beforeChange = 0;

    BlocProvider.of<FavouriteBloc>(context).add(
      GetFavouriteJobs(),
    );

    onSetJobsToFavourite(String id, int? isFav) async {
      beforeChange = favouriteListLength;

      if (isFav == 1) {
        favouriteListLength--;
      } else {
        favouriteListLength++;
      }

      BlocProvider.of<JobCardBloc>(context).add(
        ToggleFavouriteEvent(
          jobId: id,
        ),
      );
    }

    onSubmitToJob(String id) {
      BlocProvider.of<JobCardBloc>(context).add(
        ToggleApplyEvent(
          jobId: id,
        ),
      );
    }

    goToJobDetails(JobModel job) {
      context.pushNamed(
        PAGES.jobDetails.screenName,
        extra: [
          job,
          booleanIsCompany(user!.role),
        ],
      );
    }

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
      body: Container(
        margin: const EdgeInsets.only(top: gap / 2),
        color: ColorsConst.white,
        child: SafeArea(
          child: user!.role == 'user' || user.role == 'old_student'
              ? user.complete!['profile'] && user.complete!['submission']
                  ? HomeJobsContainer(
                      context: context,
                      favouriteListLength: favouriteListLength,
                      beforeChange: beforeChange,
                      user: user,
                      scaffoldMessengerKey: scaffoldMessengerKey,
                      setJobsToFavourite: (index, list) {
                        onSetJobsToFavourite(
                          list[index].id.toString(),
                          list[index].isFavourite,
                        );
                      },
                      submitToJob: (index, list) {
                        onSubmitToJob(
                          list[index].id.toString(),
                        );
                      },
                      toJobDetails: (index, list) {
                        goToJobDetails(list[index]);
                      },
                      onTap: () {
                        onNavigationButtonPressed(PAGES.listing.screenPath);
                      },
                      onSetJobsToFavourite: onSetJobsToFavourite,
                      onSubmitToJob: onSubmitToJob,
                      goToJobDetails: goToJobDetails,
                    )
                  : NonCompleteAccountContainer(
                      context: context,
                      scaffoldMessengerKey: scaffoldMessengerKey,
                      favouriteListLength: favouriteListLength,
                      user: user,
                      onTap: () {
                        onNavigationButtonPressed(PAGES.listing.screenPath);
                      },
                    )
              : HomeJobsContainer(
                  context: context,
                  favouriteListLength: favouriteListLength,
                  beforeChange: beforeChange,
                  user: user,
                  scaffoldMessengerKey: scaffoldMessengerKey,
                  setJobsToFavourite: (index, list) {
                    onSetJobsToFavourite(
                      list[index].id.toString(),
                      list[index].isFavourite,
                    );
                  },
                  submitToJob: (index, list) {
                    onSubmitToJob(
                      list[index].id.toString(),
                    );
                  },
                  toJobDetails: (index, list) {
                    goToJobDetails(list[index]);
                  },
                  onTap: () {
                    onNavigationButtonPressed(PAGES.listing.screenPath);
                  },
                  onSetJobsToFavourite: onSetJobsToFavourite,
                  onSubmitToJob: onSubmitToJob,
                  goToJobDetails: goToJobDetails,
                ),
        ),
      ),
    );
  }
}
