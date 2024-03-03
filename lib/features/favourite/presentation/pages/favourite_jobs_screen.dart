// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/list_is_empty_message.dart';
import '../../../auth/domain/usecases/update_apply_status.dart';
import '../../../auth/domain/usecases/update_favourite_status.dart';
import '../../../auth/presentation/widgets/responsive_card.dart';
import '../../../listings/data/models/job_model.dart';
import '../../../listings/presentation/job_card_bloc/job_card_bloc.dart';
import '../favourite_bloc/favourite_bloc.dart';

class FavouriteJobsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const FavouriteJobsScreen({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavouriteBloc>(context).add(
      GetFavouriteJobs(),
    );

    int favouriteListLength = 0;
    int beforeChange = 0;

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
        extra: [job],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Αγαπημένες Αγγελίες',
          ),
        ),
        body: BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, state) {
            if (state is FavouriteEmpty) {
              favouriteListLength = 0;

              return SafeArea(
                child: ListIsEmptyMessage(
                  context: context,
                  text: 'Δεν έχει προστεθεί κάμια αγγελία στα αγαπημένα.',
                ),
              );
            }
            if (state is FavouriteNotEmpty) {
              var list = state.favJobs;

              favouriteListLength = state.favJobs.length;

              return SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: BlocConsumer<JobCardBloc, JobCardState>(
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

                        list.removeWhere(
                          (element) => element.id.toString() == state.jobId,
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
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return ResponsiveCard(
                              list: list,
                              index: index,
                              toggleFav: () {
                                onSetJobsToFavourite(
                                  list[index].id.toString(),
                                  list[index].isFavourite,
                                );
                              },
                              toggleApply: () {
                                onSubmitToJob(
                                  list[index].id.toString(),
                                );
                              },
                              showDetails: () {
                                goToJobDetails(list[index]);
                              },
                              context: context);
                        },
                      );
                    },
                  ),
                ),
              );
            }
            return CustomLoading(ColorsConst.primaryColor,);
          },
        ));
  }
}
