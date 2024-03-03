import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import 'search_result_header.dart';

Widget InfoTextForTextfield({
  required BuildContext context,
  required bool isHidden,
  required String text,
  required Function function,
  bool showResultText = false,
}) {
  return SliverToBoxAdapter(
    child: isHidden
        ? Container(
            padding: const EdgeInsets.all(padding),
            margin: const EdgeInsets.all(
              padding,
            ),
            decoration: BoxDecoration(
              color: ColorsConst.primaryColor,
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              border: Border.all(
                color: ColorsConst.darkgreyColor,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.info,
                  color: ColorsConst.white,
                  size: calculateFontSize(
                    context,
                    20,
                  ),
                ),
                const SizedBox(
                  width: gap / 2,
                ),
                Expanded(
                  child: Text(
                    'Η αναζήτηση λειτουργεί για λέξεις από 3 γράμματα και πάνω!',
                    style: TextStyle(
                      fontSize: calculateFontSize(
                        context,
                        normalText,
                      ),
                      color: ColorsConst.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        : SearchResultHeader(
            context: context,
            text: text,
            showResultText: showResultText,
            function: function,
          ),
  );
}
