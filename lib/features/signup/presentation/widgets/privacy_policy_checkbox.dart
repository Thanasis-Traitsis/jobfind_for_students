import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/usecases/calculate_font_size.dart';

Widget PrivacyPolicyCheckbox({
  required Function(bool?) function,
  required bool isChecked,
  required bool showError,
  required BuildContext context,
}) {
  return Column(
    children: [
      CheckboxListTile(
        activeColor: ColorsConst.primaryColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
        title: Text(
          'Με την εγγραφή σας, εισάγεστε στη βάση δεδομένων του JobFind for Students',
          style: TextStyle(
            fontSize: calculateFontSize(context, smallText),
          ),
        ),
        value: isChecked,
        onChanged: function,
      ),
      Container(
        margin: const EdgeInsets.only(top: 5, bottom: 10),
        child: Text(
          !showError
              ? ''
              : 'Παρακαλώ αποδεχτείτε τους όρους για να προχωρήσετε στην εγγραφή του λογαριασμού σας.',
          style: TextStyle(
            fontSize: calculateFontSize(context, smallText),
            color: ColorsConst.errorColor,
          ),
        ),
      ),
    ],
  );
}
