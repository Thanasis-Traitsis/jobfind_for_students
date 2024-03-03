import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/urls.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../../core/utils/scaffold_message.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../profile/presentation/image_bloc/image_bloc.dart';

Widget ProfileAvatar({
  required BuildContext context,
  required String? imageLink,
  required String lastNameLetter,
  required String firstNameLetter,
  required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  bool fullSize = false,
}) {
  return BlocConsumer<ImageBloc, ImageState>(
    listener: (context, state) {
      if (state is ImageFailure) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          ScaffoldMessage(
            context: context,
            message: state.message,
            isWarning: true,
            onTap: () {
              scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
            },
          ),
        );
      }
      if (state is ImageSuccess) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          ScaffoldMessage(
            context: context,
            message: state.message,
            onTap: () {
              scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
            },
          ),
        );
      }
    },
    builder: (context, state) {
      return Container(
        height: fullSize ? double.infinity : calculateFontSize(context, 65),
        width: fullSize ? double.infinity : calculateFontSize(context, 65),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
          color: ColorsConst.primaryColor,
        ),
        child: state is ImageLoading
            ? Center(
                child: CustomLoading(ColorsConst.white),
              )
            : state is ImageSuccess
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      borderRadius,
                    ),
                    child: CachedNetworkImage(
                      key: UniqueKey(),
                      imageUrl: publicUrl + state.image,
                      fit: BoxFit.cover,
                    ),
                  )
                : imageLink != null && imageLink != ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                          borderRadius,
                        ),
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          imageUrl: publicUrl + imageLink,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              lastNameLetter,
                              style: TextStyle(
                                color: ColorsConst.white,
                                fontSize: calculateFontSize(
                                  context,
                                  fullSize ? heading1 : veryLargeText,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: fullSize ? 5 : 2,
                            ),
                            Text(
                              firstNameLetter,
                              style: TextStyle(
                                color: ColorsConst.white,
                                fontSize: calculateFontSize(
                                  context,
                                  fullSize ? heading1 : veryLargeText,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
      );
    },
  );
}
