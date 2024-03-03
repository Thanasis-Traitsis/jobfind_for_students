import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../auth/presentation/widgets/big_job_card/icon_with_text.dart';
import '../../../listings/domain/usecases/transform_date.dart';
import '../../../listings/domain/usecases/transform_views.dart';

Widget DetailsCardHeader({
  required BuildContext context,
  required String date,
  required String? views,
  required bool hasViewed,
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconWithText(
            context: context,
            icon: FontAwesomeIcons.clockRotateLeft,
            text: transformDate(date),
          ),
          IconWithText(
            context: context,
            icon: FontAwesomeIcons.solidEye,
            text: hasViewed
                ? transformViews(views)
                : (int.parse(transformViews(views)) + 1).toString(),
          ),
        ],
      ),
      Divider(
        thickness: .5,
        color: ColorsConst.primaryColor,
      ),
    ],
  );
}
