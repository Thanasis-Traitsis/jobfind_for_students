import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/icons.dart';
import '../../../../../core/utils/routes_utils.dart';
import '../outline_icon_button.dart';

Widget ButtonsContainer({
  bool isLandscape = false,
  required BuildContext context,
  required Function onReturn,
  required Function studentSignUp,
}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: OutlineIconButton(
              icon: oldStudentIcon,
              text: 'Απόφοιτος',
              isLandscape: isLandscape,
              onPressed: () {
                context
                    .pushNamed(
                      PAGES.signupOld.screenName,
                      extra: null,
                    )
                    .then(
                      (value) => onReturn(),
                    );
              },
              context: context,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: OutlineIconButton(
              icon: businessIcon,
              text: 'Επιχείρηση',
              isLandscape: isLandscape,
              onPressed: () {
                context.push(PAGES.signupComp.screenPath).then(
                      (value) => onReturn(),
                    );
              },
              context: context,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      SizedBox(
        width: double.infinity,
        child: OutlineIconButton(
          icon: studentIcon,
          text: 'Φοιτητής',
          isHighlight: true,
          isLandscape: isLandscape,
          onPressed: () {
            studentSignUp();
          },
          context: context,
        ),
      ),
    ],
  );
}
