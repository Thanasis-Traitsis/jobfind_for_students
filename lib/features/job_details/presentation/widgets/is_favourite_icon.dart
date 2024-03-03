import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';

Widget IsFavouriteICon({
  required bool isFav,
}) {
  return isFav
      ? Icon(
          FontAwesomeIcons.solidHeart,
          color: ColorsConst.secondHighlightColor,
        )
      : const Icon(FontAwesomeIcons.heart);
}
