import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import 'search_textfield.dart';

Widget SearchAndFilterAppbar({
  required BuildContext context,
  required TextEditingController searchController,
  required Function(String) function,
  required VoidCallback onTap,
}) {
  return SliverAppBar(
    title: Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SearchTextfield(
              controller: searchController,
              function: () {
                function(searchController.text);
              },
            ),
          ),
          const SizedBox(
            width: gap,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
            onTap: onTap,
            child: Container(
              width: calculateFontSize(
                context,
                headerRowSize + 5,
              ),
              height: calculateFontSize(
                context,
                headerRowSize + 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  borderRadius,
                ),
                border: Border.all(
                  color: ColorsConst.lightgreyColor,
                  width: 2,
                ),
              ),
              child: Icon(
                FontAwesomeIcons.barsStaggered,
                color: ColorsConst.darkgreyColor,
                size: calculateFontSize(
                  context,
                  30,
                ),
              ),
            ),
          )
        ],
      ),
    ),
    titleSpacing: 0,
    backgroundColor: ColorsConst.white,
    pinned: false,
    floating: true,
    toolbarHeight: calculateFontSize(
      context,
      85,
    ),
    flexibleSpace: Container(
      color: ColorsConst.white,
    ),
  );
}
