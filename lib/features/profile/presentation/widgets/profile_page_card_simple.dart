import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../../core/widgets/custom_loading.dart';

Widget ProfilePageCardSimple({
  required BuildContext context,
  required IconData icon,
  required String text,
  required Function onPressed,
  bool logout = false,
  bool isLoading = false,
  bool isSuccess = false,
  bool isDisabled = false,
}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color:
              logout ? ColorsConst.redColor.withOpacity(.2) : ColorsConst.white,
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
          border: Border.all(
            color: isDisabled
                ? ColorsConst.lightgreyColor
                : logout
                    ? ColorsConst.redColor
                    : ColorsConst.darkgreyColor,
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              isDisabled ? null : onPressed();
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              color: isDisabled
                                  ? ColorsConst.lightgreyColor
                                  : logout
                                      ? ColorsConst.redColor
                                      : ColorsConst.darkgreyColor,
                              size: calculateFontSize(
                                context,
                                30,
                              ),
                            ),
                            const SizedBox(
                              width: gap,
                            ),
                            Expanded(
                              child: Text(
                                text,
                                style: TextStyle(
                                  color: isDisabled
                                      ? ColorsConst.lightgreyColor
                                      : logout
                                          ? ColorsConst.redColor
                                          : ColorsConst.darkgreyColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: calculateFontSize(
                                    context,
                                    largeText,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      isLoading
                          ? SizedBox(
                              width: calculateFontSize(context, 16),
                              height: calculateFontSize(context, 16),
                              child: Transform.scale(
                                scale: .9,
                                child: CustomLoading(
                                  ColorsConst.primaryColor,
                                ),
                              ),
                            )
                          : isSuccess
                              ? Icon(
                                  FontAwesomeIcons.check,
                                  color: Colors.green,
                                  size: calculateFontSize(
                                    context,
                                    20,
                                  ),
                                )
                              : Icon(
                                  FontAwesomeIcons.angleRight,
                                  color: isDisabled
                                      ? ColorsConst.lightgreyColor
                                      : logout
                                          ? ColorsConst.redColor
                                          : ColorsConst.darkgreyColor,
                                  size: calculateFontSize(
                                    context,
                                    20,
                                  ),
                                ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      logout
          ? Container()
          : const SizedBox(
              height: gap / 2,
            ),
    ],
  );
}
