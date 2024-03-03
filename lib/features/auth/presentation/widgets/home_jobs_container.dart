import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../favourite/presentation/favourite_bloc/favourite_bloc.dart';
import '../../../listings/presentation/job_bloc/job_bloc.dart';
import '../../../listings/presentation/job_card_bloc/job_card_bloc.dart';
import '../../../listings/presentation/widgets/center_empty_text.dart';
import '../../../listings/presentation/widgets/job_list.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/boolean_is_company.dart';
import '../../domain/usecases/update_apply_status.dart';
import '../../domain/usecases/update_favourite_status.dart';
import 'applicants_card/applicants_list.dart';
import 'header_row_container.dart';
import 'recent_jobs_header.dart';
import 'recommended_container.dart';
import 'responsive_card.dart';
import 'welcome_text_container.dart';

Widget HomeJobsContainer({
  required BuildContext context,
  required int favouriteListLength,
  required int beforeChange,
  required UserModel user,
  required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  required Function(int, List) setJobsToFavourite,
  required Function(int, List) submitToJob,
  required Function(int, List) toJobDetails,
  required Function onSetJobsToFavourite,
  required Function onSubmitToJob,
  required Function goToJobDetails,
  required VoidCallback onTap,
}) {
  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
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
            BlocBuilder<JobBloc, JobState>(
              builder: (context, state) {
                if (state is JobsRecent) {
                  var list = state.recomJobs;

                  return list.isNotEmpty
                      ? BlocConsumer<JobCardBloc, JobCardState>(
                          listener: (context, state) {
                            if (state is JobCardFavourite) {
                              updateFavouriteStatus(
                                listLength: favouriteListLength,
                                context: context,
                                beforeChange: beforeChange,
                                list: list,
                                id: state.jobId,
                                isFav: state.isFav,
                              );
                            }
                            if (state is JobCardApply) {
                              updateApplyStatus(
                                context: context,
                                list: list,
                                id: state.jobId,
                                hasAppl: state.hasApplied,
                              );
                            }
                          },
                          builder: (context, state) {
                            return RecommendedContainer(
                              context: context,
                              smallCard: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return ResponsiveCard(
                                    key: UniqueKey(),
                                    list: list,
                                    index: index,
                                    toggleFav: () {
                                      setJobsToFavourite(index, list);
                                    },
                                    toggleApply: () {
                                      submitToJob(index, list);
                                    },
                                    showDetails: () {
                                      toJobDetails(index, list);
                                    },
                                    context: context,
                                    isBigCard: false,
                                  );
                                },
                              ),
                            );
                          },
                        )
                      : Container();
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(
              height: gap / 2,
            ),
          ],
        ),
      ),
      SliverAppBar(
        title: RecentJobsHeader(
          context: context,
          onTap: onTap,
          role: user.role!,
        ),
        titleSpacing: 0,
        backgroundColor: ColorsConst.white,
        pinned: true,
        toolbarHeight: 60,
        flexibleSpace: Container(
          color: ColorsConst.white,
        ),
      ),
      BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobsRecent) {
            var list = booleanIsCompany(user.role)
                ? state.recentApplicants
                : state.recentJobs;

            return list.isEmpty
                ? CenterEmptyText(
                    context: context,
                    text: booleanIsCompany(user.role)
                        ? 'Δεν υπάρχει κάποια πρόσφατη αίτηση.'
                        : 'Δεν υπάρχει καμία διαθέσιμη αγγελία.',
                  )
                : booleanIsCompany(user.role)
                    ? ApplicantsList(
                        list: list,
                      )
                    : JobList(
                        list: list,
                        stateList: state.recentJobs,
                        favFunction: onSetJobsToFavourite,
                        submitFunction: onSubmitToJob,
                        detailsFunction: goToJobDetails,
                        isCompany: booleanIsCompany(user.role),
                      );
          } else {
            return SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: Center(
                  child: Transform.scale(
                    scale: 1.4,
                    child: CustomLoading(
                      ColorsConst.primaryColor,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    ],
  );
}
