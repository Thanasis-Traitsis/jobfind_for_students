import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget SearchResultHeader({
  required bool showResultText,
  required BuildContext context,
  required String text,
  required Function function,
}) {
  return showResultText
      ? Container(
          margin: const EdgeInsets.all(
            padding,
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Αποτελέσματα αναζήτησης : ',
                style: TextStyle(
                  fontSize: calculateFontSize(
                    context,
                    mediumText,
                  ),
                  color: ColorsConst.textColor,
                ),
              ),
              const SizedBox(
                width: gap / 2,
              ),
              RawChip(
                backgroundColor: ColorsConst.primaryColor,
                label: Text(
                  "'$text'",
                  style: TextStyle(
                    color: ColorsConst.white,
                    fontSize: calculateFontSize(
                      context,
                      normalText,
                    ),
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                onDeleted: () {
                  function();
                },
                deleteIcon: Icon(
                  FontAwesomeIcons.xmark,
                  size: calculateFontSize(
                    context,
                    20,
                  ),
                  color: ColorsConst.white,
                ),
              ),
            ],
          ),
        )
      : Container();
}
