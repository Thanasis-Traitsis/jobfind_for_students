import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget TextBetweenLines(BuildContext context) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 15.0),
          child: Divider(
            color: ColorsConst.lightgreyColor,
            height: 5,
          ),
        ),
      ),
      Text(
        'ή εγγραφείτε ως',
        style: TextStyle(
            color: ColorsConst.lightgreyColor,
            fontSize: calculateFontSize(context, normalText)),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 15.0),
          child: Divider(
            color: ColorsConst.lightgreyColor,
            height: 5,
          ),
        ),
      ),
    ],
  );
}
