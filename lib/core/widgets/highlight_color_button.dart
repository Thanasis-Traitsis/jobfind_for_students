import 'package:flutter/material.dart';

import '../../config/theme/colors.dart';
import '../constants/font_size.dart';
import '../constants/styles.dart';
import '../usecases/calculate_font_size.dart';
import 'custom_loading.dart';

Widget HighlighColorButton({
  required VoidCallback onPressed,
  required String text,
  required BuildContext context,
  bool isLoading = false,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    onPressed: onPressed,
    child: SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 20,
            height: 20,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: calculateFontSize(context, normalText),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: isLoading
                ? CustomLoading(
                    ColorsConst.white,
                  )
                : null,
          ),
        ],
      ),
    ),
  );
}
