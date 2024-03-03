import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/usecases/update_apply_status.dart';
import '../../../auth/domain/usecases/update_favourite_status.dart';
import '../../../auth/domain/usecases/update_views_status.dart';
import '../../../auth/presentation/widgets/responsive_card.dart';
import '../../data/models/job_model.dart';
import '../job_card_bloc/job_card_bloc.dart';

Widget JobList({
  required List<JobModel> stateList,
  List? list,
  required Function favFunction,
  required Function submitFunction,
  required Function detailsFunction,
  bool isCompany = false,
}) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return BlocConsumer<JobCardBloc, JobCardState>(
          listener: (context, state) {
            if (state is JobCardFavourite) {
              updateFavouriteStatus(
                context: context,
                list: list!,
                id: state.jobId,
                isFav: state.isFav,
              );
            }
            if (state is JobCardApply) {
              updateApplyStatus(
                context: context,
                list: list!,
                id: state.jobId,
                hasAppl: state.hasApplied,
              );
            }
            if (state is JobCardViewed) {
              updateViewsStatus(
                context: context,
                list: list!,
                id: state.jobId,
                hasViewed: state.hasViewed,
                views: state.views,
              );
            }
          },
          builder: (context, state) {
            return ResponsiveCard(
              key: UniqueKey(),
              list: list!,
              index: index,
              toggleFav: () {
                favFunction(
                  list[index].id.toString(),
                  list[index].isFavourite,
                );
              },
              toggleApply: () {
                submitFunction(
                  list[index].id.toString(),
                );
              },
              showDetails: () {
                detailsFunction(list[index]);
              },
              context: context,
              isCompany: isCompany,
            );
          },
        );
      },
      childCount: list != null ? list.length : stateList.length,
    ),
  );
}
