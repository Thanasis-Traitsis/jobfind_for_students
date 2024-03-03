import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../profile_page_card_simple.dart';

Widget ResumeCard({
  required BuildContext context,
  required Function onPressed,
  bool isLoading = false,
  bool isSuccess = false,
}) {
  return Expanded(
    child: ProfilePageCardSimple(
      context: context,
      icon: FontAwesomeIcons.file,
      text: 'Βιογραφικό Σημείωμα',
      onPressed: onPressed,
      isLoading: isLoading,
      isSuccess: isSuccess,
    ),
  );
}
