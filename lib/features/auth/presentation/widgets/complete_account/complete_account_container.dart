import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/containers.dart';
import '../../../../../core/constants/styles.dart';
import 'first_step.dart';
import 'header_container.dart';
import 'second_step.dart';

Widget CompleteAccountContainer({
  required BuildContext context,
  required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  bool completedProfileStep = false,
  bool completedSubmissionStep = false,
  bool completedResume = false,
  bool completedImage = false,
}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(padding),
      child: Container(
        padding: const EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: ColorsConst.lightgreyColor.withOpacity(.2),
          border: Border.all(
            color: ColorsConst.lightgreyColor,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderContainer(
              context: context,
            ),
            const SizedBox(
              height: gap / 2,
            ),
            FirstStep(
              context: context,
              completedProfileStep: completedProfileStep,
              completedImage: completedImage,
              completedResume: completedResume,
            ),
            const SizedBox(
              height: gap / 2,
            ),
            SecondStep(
              context: context,
              scaffoldMessengerKey: scaffoldMessengerKey,
              completedSubmissionStep: completedSubmissionStep,
            ),
          ],
        ),
      ),
    ),
  );
}
