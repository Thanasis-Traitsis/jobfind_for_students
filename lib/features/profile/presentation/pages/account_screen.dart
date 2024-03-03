// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/errors/error_model.dart';
import '../../../../core/utils/scaffold_message.dart';
import '../../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../edit_account_bloc/edit_account_bloc.dart';
import '../widgets/textfields_container.dart';
import '../widgets/buttons/update_account_button.dart';

class AccountScreen extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final List userBody;

  const AccountScreen({
    Key? key,
    required this.scaffoldMessengerKey,
    required this.userBody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> textControllerList = [];

    String? id;
    Map initialBody = {};

    // Set the errors
    ErrorModel? errors;

    onUpdateAccountButtonPressed() async {
      bool isEdited = false;
      Map body = {};

      for (var i = 0; i < userBody.length; i++) {
        body[userBody[i]] = textControllerList[i].text;
      }

      List keys = body.keys.toList();

      for (var i = 0; i < body.length; i++) {
        if (!(initialBody[keys[i]] == body[keys[i]])) {
          isEdited = true;
        }
      }

      if (isEdited) {
        BlocProvider.of<EditAccountBloc>(context).add(
          UpdateAccountButtonPressed(
            body: body,
            id: id!,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Λογαριασμός',
        ),
      ),
      body: SafeArea(
        child: BlocListener<EditAccountBloc, EditAccountState>(
          listener: (context, state) {
            if (state is EditAccountFailure) {
              scaffoldMessengerKey.currentState?.showSnackBar(
                ScaffoldMessage(
                  context: context,
                  message: state.message,
                  onTap: () {
                    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
                  },
                ),
              );

              errors = state.errors;
            }

            if (state is EditAccountSuccess) {
              scaffoldMessengerKey.currentState?.showSnackBar(
                ScaffoldMessage(
                  context: context,
                  message: state.message,
                  onTap: () {
                    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
                  },
                ),
              );

              context.pop();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(padding),
            color: ColorsConst.white,
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  textControllerList = [];

                  for (var i = 0; i < userBody.length; i++) {
                    textControllerList.add(TextEditingController());

                    textControllerList[i].text =
                        state.user!.toJson()[userBody[i]] ?? '';

                    initialBody[userBody[i]] = textControllerList[i].text;
                  }

                  id = state.user!.id!.toString();
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<EditAccountBloc, EditAccountState>(
                      builder: (context, state) {
                        return TextfieldsContainer(
                          context: context,
                          errors: errors,
                          textControllerList: textControllerList,
                          listBody: userBody,
                        );
                      },
                    ),
                    UpdateAccountButton(
                      context: context,
                      function: onUpdateAccountButtonPressed,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
