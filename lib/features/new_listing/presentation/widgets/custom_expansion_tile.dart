import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget CustomExpansionTile({
  required heading,
  required BuildContext context,
  required List list,
  required List myList,
  required Function(int) onChanged,
  bool isMajor = false,
}) {
  return ExpansionTile(
    tilePadding: const EdgeInsets.all(0),
    textColor: ColorsConst.primaryColor,
    iconColor: ColorsConst.primaryColor,
    collapsedTextColor: ColorsConst.textColor,
    collapsedIconColor: ColorsConst.textColor,
    title: Text(
      heading,
      style: TextStyle(
        fontSize: calculateFontSize(
          context,
          normalText,
        ),
      ),
    ),
    children: [
      ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            contentPadding: const EdgeInsets.all(0),
            activeColor: ColorsConst.primaryColor,
            title: Text(
              isMajor ? list[index]['name'] : list[index],
              style: TextStyle(
                fontSize: calculateFontSize(
                  context,
                  smallText,
                ),
              ),
            ),
            value: myList.contains(
              isMajor ? list[index]['id'] : list[index],
            ),
            onChanged: (value) {
              onChanged(index);
            },
            controlAffinity: ListTileControlAffinity.leading,
          );
        },
      ),
    ],
  );
}
