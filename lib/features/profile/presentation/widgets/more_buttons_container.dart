import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/routes_utils.dart';
import '../../domain/usecases/get_users_account_body.dart';
import 'profile_page_card_simple.dart';
import 'resume_container/resume_container.dart';
import 'submit_status_container.dart';

Widget MoreButtonsContainer({
  required BuildContext context,
  required Function logoutPressed,
  required String role,
  required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  bool isCompany = false,
}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            ProfilePageCardSimple(
              context: context,
              icon: FontAwesomeIcons.userGear,
              text: 'Λογαριασμός',
              onPressed: () async {
                await getUsersAccountBody(role).then(
                  (value) {

                    context.pushNamed(
                      PAGES.account.screenName,
                      extra: [
                        value,
                      ],
                    );
                  },
                );
              },
            ),
            isCompany
                ? Container()
                : ResumeContainer(
                    scaffoldMessengerKey: scaffoldMessengerKey,
                  ),
            isCompany
                ? Container()
                : SubmitStatusContainer(
                    scaffoldMessengerKey: scaffoldMessengerKey,
                  )
          ],
        ),
        ProfilePageCardSimple(
          context: context,
          icon: FontAwesomeIcons.doorOpen,
          text: 'Αποσύνδεση',
          onPressed: logoutPressed,
          logout: true,
        ),
      ],
    ),
  );
}
