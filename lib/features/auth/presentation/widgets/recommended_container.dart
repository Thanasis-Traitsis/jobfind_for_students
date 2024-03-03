import 'package:flutter/material.dart';

import '../../../../core/constants/containers.dart';
import 'header_text.dart';

Widget RecommendedContainer({
  required BuildContext context,
  required Widget smallCard,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: padding,
        ),
        height: 60,
        alignment: Alignment.centerLeft,
        child: HeaderText(
          context: context,
          text: 'Συνιστάται για εσάς',
        ),
      ),
      SizedBox(
        height: 190,
        child: smallCard,
      ),
    ],
  );
}
