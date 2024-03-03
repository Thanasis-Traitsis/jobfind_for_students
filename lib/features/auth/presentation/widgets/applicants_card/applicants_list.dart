import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../listings/presentation/job_card_bloc/job_card_bloc.dart';
import 'applicants_card.dart';

Widget ApplicantsList({
  required List list,
}) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return BlocBuilder<JobCardBloc, JobCardState>(
          builder: (context, state) {
            return ApplicantsCard(
              context: context,
              list: list[index],
            );
          },
        );
      },
      childCount: list.length,
    ),
  );
}
