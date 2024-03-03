// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/errors/error_model.dart';
import '../../../../core/utils/scaffold_message.dart';
import '../request_degree_bloc/request_degree_bloc.dart';
import '../widgets/buttons/request_degree_button.dart';
import '../widgets/textfields_container.dart';

class RequestDegreeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final List requestBody;
  final List<TextEditingController> textControllerList;

  const RequestDegreeScreen({
    Key? key,
    required this.scaffoldMessengerKey,
    required this.requestBody,
    required this.textControllerList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set the errors
    ErrorModel? errors;

    onRequestDegreeButtonPressed() async {
      Map body = {};

      for (var i = 0; i < requestBody.length; i++) {
        body[requestBody[i]] = textControllerList[i].text;
      }

      BlocProvider.of<RequestDegreeBloc>(context).add(
        RequestDegreeButtonPressed(
          body: body,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Αίτηση Πτυχίου',
        ),
      ),
      body: SafeArea(
        child: BlocListener<RequestDegreeBloc, RequestDegreeState>(
          listener: (context, state) {
            if (state is RequestDegreeFailure) {
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

            if (state is RequestDegreeSuccess) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<RequestDegreeBloc, RequestDegreeState>(
                  builder: (context, state) {
                    return TextfieldsContainer(
                      context: context,
                      errors: errors,
                      textControllerList: textControllerList,
                      listBody: requestBody,
                    );
                  },
                ),
                RequestDegreeButton(
                  context: context,
                  function: onRequestDegreeButtonPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
