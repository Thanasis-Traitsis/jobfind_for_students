import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget ProfilePageCard({
  required BuildContext context,
  required String text,
  required Color color,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color.withOpacity(.2),
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
      border: Border.all(
        color: color,
        width: 1,
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: color.withOpacity(.2),
        onTap: onTap,
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
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(
                              borderRadius,
                            ),
                          ),
                          child: Icon(
                            icon,
                            color: ColorsConst.white,
                            size: calculateFontSize(
                              context,
                              30,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: gap / 2,
                        ),
                        Expanded(
                          child: Text(
                            text,
                            style: TextStyle(
                              color: color,
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
                  Icon(
                    FontAwesomeIcons.angleRight,
                    color: color,
                    size: calculateFontSize(
                      context,
                      30,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
