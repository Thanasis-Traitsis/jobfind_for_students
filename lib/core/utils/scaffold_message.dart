import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/theme/colors.dart';
import '../constants/font_size.dart';
import '../usecases/calculate_font_size.dart';

SnackBar ScaffoldMessage({
  required String message,
  required onTap,
  required BuildContext context,
  bool noError = true,
  bool isWarning = false,
}) {
  return SnackBar(
    backgroundColor: noError
        ? isWarning
            ? ColorsConst.warningColor
            : ColorsConst.primaryColor
        : ColorsConst.errorColor,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              color: ColorsConst.white,
              fontSize: calculateFontSize(context, normalText),
            ),
          ),
        ),
        noError
            ? isWarning
                ? Icon(
                    FontAwesomeIcons.exclamation,
                    color: ColorsConst.white,
                  )
                : InkWell(
                    onTap: onTap,
                    child: Icon(
                      Icons.close,
                      color: ColorsConst.white,
                    ),
                  )
            : Icon(
                Icons.signal_wifi_connected_no_internet_4_rounded,
                color: ColorsConst.white,
              ),
      ],
    ),
    elevation: 5,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    duration: noError ? const Duration(seconds: 3) : const Duration(days: 1),
  );
}
