import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../listings/presentation/job_card_bloc/job_card_bloc.dart';

Widget FloatingFullWidthButton({
  required bool hasApplied,
  required Function function,
  bool isMyJob = false,
  int? applicantsCount,
}) {
  return BlocConsumer<JobCardBloc, JobCardState>(
    listener: (context, state) {
      if (state is JobCardApply) {
        hasApplied = state.hasApplied;
      }
    },
    builder: (context, state) {
      return Container(
        margin: const EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: hasApplied
              ? ColorsConst.secondHighlightColor
              : ColorsConst.highlightColor,
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
        height: floatingButtonHeight,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            backgroundColor: hasApplied
                ? ColorsConst.secondHighlightColor
                : ColorsConst.highlightColor,
          ),
          child: Text(
            isMyJob ? '$applicantsCount Αιτήσεις' : hasApplied ? 'Ακύρωση Αίτησης' : 'Αίτηση',
            style: TextStyle(
              fontSize: calculateFontSize(
                context,
                veryLargeText,
              ),
              fontWeight: FontWeight.bold,
              color: ColorsConst.white,
            ),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            function();
          },
        ),
      );
    },
  );
}
