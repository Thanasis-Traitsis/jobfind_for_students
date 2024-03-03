import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_font_size.dart';
import '../../../../profile/presentation/widgets/submit_status_container.dart';

Widget SecondStep({
  required BuildContext context,
  required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  bool completedSubmissionStep = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          completedSubmissionStep
              ? Icon(
                  FontAwesomeIcons.solidCircleCheck,
                  color: ColorsConst.greenColor,
                  size: calculateFontSize(
                    context,
                    25,
                  ),
                )
              : Container(),
          completedSubmissionStep
              ? const SizedBox(
                  width: gap / 2,
                )
              : Container(),
          Text(
            '2ο Βήμα (Αίτηση Πτυχίου)',
            style: TextStyle(
              color: ColorsConst.textColor,
              fontSize: calculateFontSize(
                context,
                largeText,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      const SizedBox(height: gap / 2),
      SubmitStatusContainer(
        scaffoldMessengerKey: scaffoldMessengerKey,
      ),
    ],
  );
}
