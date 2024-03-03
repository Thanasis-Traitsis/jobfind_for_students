import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget HeaderButton({
  required BuildContext context,
  required String text,
  required Function function,
  bool isClicked = false,
}) {
  return Expanded(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          function();
        },
        child: Container(
          decoration: BoxDecoration(
            color: isClicked ? ColorsConst.highlightColor : null,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                10,
              ),
              topRight: Radius.circular(
                10,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(padding),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isClicked
                      ? ColorsConst.white
                      : ColorsConst.textColor.withOpacity(.5),
                ),
              ),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: calculateFontSize(
                  context,
                  mediumText,
                ),
                fontWeight: FontWeight.bold,
                color: isClicked
                    ? ColorsConst.white
                    : ColorsConst.textColor.withOpacity(.7),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
