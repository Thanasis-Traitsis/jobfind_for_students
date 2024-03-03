import 'package:flutter/material.dart';

import '../../../../core/constants/styles.dart';
import '../../../auth/data/models/user_model.dart';
import 'profile_page_avatar.dart';
import 'user_details.dart';

Widget ProfilePageHeader({
  required BuildContext context,
  required UserModel user,
  required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
}) {
  return Container(
    margin: const EdgeInsets.only(
      bottom: gap,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ProfilePageAvatar(
          context: context,
          user: user,
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
        const SizedBox(
          width: gap / 2,
        ),
        Expanded(
          child: UserDetails(
            context: context,
            user: user,
          ),
        ),
      ],
    ),
  );
}
