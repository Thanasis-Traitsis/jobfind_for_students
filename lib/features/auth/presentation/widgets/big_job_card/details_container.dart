import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/styles.dart';
import 'big_card_details_text.dart';
import 'icon_with_text.dart';

Widget DetailsContainer({
  required BuildContext context,
  required String city,
  required String employmentType,
  required String experience,
  required String date,
  required String views,
  required bool isViewed,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: gap,
      ),
      BigCardDetailsText(
        context: context,
        label: 'Τοποθεσία',
        text: city,
      ),
      BigCardDetailsText(
        context: context,
        label: 'Είδος Απασχόλησης',
        text: employmentType,
      ),
      BigCardDetailsText(
        context: context,
        label: 'Προϋπηρεσία',
        text: experience,
      ),
      const SizedBox(
        height: gap,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200,
            child: IconWithText(
              context: context,
              icon: FontAwesomeIcons.clockRotateLeft,
              text: date,
              isExpanded: true,
            ),
          ),
          IconWithText(
            context: context,
            icon: isViewed ? FontAwesomeIcons.solidEye : FontAwesomeIcons.eye,
            text: views,
          ),
        ],
      ),
    ],
  );
}
