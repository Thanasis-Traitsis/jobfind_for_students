import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../data/models/user_model.dart';
import '../auth_bloc/auth_bloc.dart';
import 'profile_avatar.dart';

Widget WelcomeTextContainer({
  required BuildContext context,
  required UserModel user,
  required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: padding,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Καλώς όρισες ,',
                    style: TextStyle(
                      fontSize: calculateFontSize(
                        context,
                        largeText,
                      ),
                      color: ColorsConst.textColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        user.last_name ?? '',
                        style: TextStyle(
                          fontSize: calculateFontSize(
                            context,
                            veryLargeText,
                          ),
                          fontWeight: FontWeight.bold,
                          color: ColorsConst.textColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          user.first_name ?? '',
                          style: TextStyle(
                            fontSize: calculateFontSize(
                              context,
                              veryLargeText,
                            ),
                            fontWeight: FontWeight.bold,
                            color: ColorsConst.textColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return ProfileAvatar(
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
          ],
        ),
        Divider(
          thickness: 1,
          color: ColorsConst.lightgreyColor,
        ),
      ],
    ),
  );
}
