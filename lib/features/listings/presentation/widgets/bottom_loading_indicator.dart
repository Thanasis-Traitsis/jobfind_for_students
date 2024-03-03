import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/custom_loading.dart';

Widget BottomLoadingIndicator({
  required bool isLoading,
  required bool canFethMore,
}) {
  return isLoading
      ? SliverToBoxAdapter(
          child: Container(
            height: gap,
            margin: const EdgeInsets.symmetric(
              vertical: gap,
            ),
            child: Center(
              child: Transform.scale(
                scale: 1.4,
                child: CustomLoading(
                  ColorsConst.primaryColor,
                ),
              ),
            ),
          ),
        )
      : canFethMore
          ? SliverToBoxAdapter(
              child: Container(),
            )
          : SliverToBoxAdapter(
              child: Container(),
            );
}
