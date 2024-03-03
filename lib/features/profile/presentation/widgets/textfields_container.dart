import 'package:flutter/material.dart';

import '../../../../core/errors/error_model.dart';
import '../../../signup/presentation/widgets/custom_signup_textfield.dart';
import '../../domain/usecases/translate_user_body.dart';

Widget TextfieldsContainer({
  required BuildContext context,
  required ErrorModel? errors,
  required List<TextEditingController> textControllerList,
  required List listBody,
}) {
  return Expanded(
    child: ListView.builder(
      itemBuilder: (context, index) {
        return CustomSignupTextfield(
          controller: textControllerList[index],
          text: translateListBody(listBody[index]),
          error: listBody[index],
          errorModel: errors,
          context: context,
        );
      },
      itemCount: textControllerList.length,
    ),
  );
}
