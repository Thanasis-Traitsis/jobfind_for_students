import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../../core/utils/routes_utils.dart';

Widget HeaderRowContainer({
  required BuildContext context,
  required List hasFav,
  bool hideFavIcon = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: padding,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          './assets/images/logo-blue.png',
          height: calculateFontSize(context, 60),
        ),
        hideFavIcon
            ? Container()
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: calculateFontSize(context, headerRowSize + 6),
                    width: calculateFontSize(context, headerRowSize + 6),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(borderRadius),
                    splashColor: ColorsConst.primaryColor.withOpacity(.5),
                    onTap: () {
                      context.pushNamed(
                        PAGES.favourite.screenName,
                      );
                    },
                    child: Container(
                      height: calculateFontSize(context, headerRowSize),
                      width: calculateFontSize(context, headerRowSize),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          borderRadius,
                        ),
                        border: Border.all(
                          color: ColorsConst.lightgreyColor,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.heart,
                          color: ColorsConst.darkgreyColor,
                          size: calculateFontSize(context, 30),
                        ),
                      ),
                    ),
                  ),
                  // OTAN EXEIS VALEI KAPOIO JOB STA FAVOURITES, TOTE NA TO ENERGOPOIEIS
                  hasFav.isNotEmpty
                      ? Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: calculateFontSize(context, 15),
                            width: calculateFontSize(context, 15),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorsConst.secondHighlightColor,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
      ],
    ),
  );
}
