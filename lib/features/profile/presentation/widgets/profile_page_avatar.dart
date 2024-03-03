import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/values.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../../core/utils/scaffold_message.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../../../auth/presentation/widgets/profile_avatar.dart';
import '../../domain/usecases/pick_and_crop_image.dart';
import '../image_bloc/image_bloc.dart';

Widget ProfilePageAvatar({
  required BuildContext context,
  required UserModel user,
  required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
}) {
  return SizedBox(
    width: calculateFontSize(context, 110),
    height: calculateFontSize(context, 110),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          left: calculateFontSize(context, 5),
          right: calculateFontSize(context, 5),
          bottom: calculateFontSize(context, 10),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return ProfileAvatar(
                fullSize: true,
                imageLink: state is AuthAuthenticated
                    ? state.user!.avatar_path
                    : user.avatar_path,
                context: context,
                lastNameLetter: user.last_name![0],
                firstNameLetter: user.first_name![0],
                scaffoldMessengerKey: scaffoldMessengerKey,
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: ColorsConst.white,
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              border: Border.all(
                color: ColorsConst.highlightColor,
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  borderRadius,
                ),
                onTap: () async {
                  var filePath = await PickAndCropImage().pickMedia();

                  if (filePath == null) return;

                  final file = await filePath.length();

                  double fileSize = file / (1024 * 1024);

                  if (fileSize > imageFileMB) {
                    scaffoldMessengerKey.currentState?.showSnackBar(
                      ScaffoldMessage(
                        context: context,
                        isWarning: true,
                        message:
                            'Η φωτογραφία υπερβαίνει το όριο των $imageFileMB MB!',
                        onTap: () {
                          scaffoldMessengerKey.currentState
                              ?.hideCurrentSnackBar();
                        },
                      ),
                    );

                    return;
                  } else {
                    BlocProvider.of<ImageBloc>(context).add(
                      UploadImageButtonPressed(
                        image: filePath,
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.camera,
                        color: ColorsConst.highlightColor,
                        size: calculateFontSize(
                          context,
                          18,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '+',
                        style: TextStyle(
                          color: ColorsConst.highlightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: calculateFontSize(
                            context,
                            veryLargeText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
