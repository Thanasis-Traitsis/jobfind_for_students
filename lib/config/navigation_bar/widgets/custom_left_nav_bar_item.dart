import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/constants/styles.dart';
import '../../../core/usecases/calculate_font_size.dart';
import '../../theme/colors.dart';

Widget CustomLeftNavBarItem({
  required BuildContext context,
  required IconData icon,
  required VoidCallback onTap,
  bool isHome = false,
  bool isSelected = false,
}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: calculateFontSize(
            context,
            20,
          ),
          color: ColorsConst.white,
        ),
        const SizedBox(
          height: gap / 3,
        ),
        Container(
          height: calculateFontSize(context, 10,),
          padding: EdgeInsets.only(left: isHome ? 2 : 0),
          child: Text(
            isSelected ? '⬤' : '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorsConst.white,
              fontSize: calculateFontSize(
                context,
                Platform.isIOS ? 7 : 9,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    ),
  );
}
