import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_font_size.dart';
import 'checkmark_with_text.dart';

Widget FirstStep({
  required BuildContext context,
  bool completedProfileStep = false,
  bool completedResume = false,
  bool completedImage = false,
  bool profileScreen = false,
  bool isStudent = true,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          completedProfileStep
              ? Icon(
                  FontAwesomeIcons.solidCircleCheck,
                  color: ColorsConst.greenColor,
                  size: calculateFontSize(
                    context,
                    25,
                  ),
                )
              : Container(),
          completedProfileStep
              ? const SizedBox(
                  width: gap / 2,
                )
              : Container(),
          Text(
            profileScreen
                ? 'Ολοκλήρωση Λογαριασμού'
                : '1ο Βήμα (Ολοκλήρωση Λογαριασμού)',
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
      CheckmarkWithText(
        context: context,
        text: "Στοιχεία λογαριασμού",
        isChecked: true,
      ),
      CheckmarkWithText(
        context: context,
        text: "Ενημέρωση φωτογραφίας προφίλ",
        isChecked: completedImage,
      ),
      isStudent
          ? CheckmarkWithText(
              context: context,
              text: "Προσθήκη βιογραφικού σημειώματος",
              isChecked: completedResume,
            )
          : Container(),
    ],
  );
}
