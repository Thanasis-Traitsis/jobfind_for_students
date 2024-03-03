import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../../core/utils/scaffold_message.dart';
import '../../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../../domain/usecases/get_request_degree_body.dart';
import '../../domain/usecases/translate_submit_status.dart';
import '../request_degree_bloc/request_degree_bloc.dart';
import 'profile_page_card_simple.dart';

class SubmitStatusContainer extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const SubmitStatusContainer({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? submId;
    String message = '';
    bool isDisabled = false;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          isDisabled = transformSubmitStatus(state.user!.submission_status);
          message = translateSubmitStatus(state.user!.submission_status);
          submId = state.user!.submission_id;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<RequestDegreeBloc, RequestDegreeState>(
              listener: (context, state) {
                // if (state is RequestDegreeFailure) {
                //   scaffoldMessengerKey.currentState?.showSnackBar(
                //     ScaffoldMessage(
                //       context: context,
                //       isWarning: true,
                //       message: state.message,
                //       onTap: () {
                //         scaffoldMessengerKey.currentState
                //             ?.hideCurrentSnackBar();
                //       },
                //     ),
                //   );
                // }
              },
              builder: (context, state) {
                return ProfilePageCardSimple(
                  isDisabled: isDisabled,
                  isLoading: state is RequestDegreeLoading ? true : false,
                  context: context,
                  icon: FontAwesomeIcons.filePen,
                  text: 'Αίτηση Πτυχίου',
                  onPressed: submId != null
                      ? () {
                          BlocProvider.of<RequestDegreeBloc>(context).add(
                            ViewSubmissionButtonPressed(
                              id: submId!.toString(),
                            ),
                          );
                        }
                      : () async {
                          await getRequestDegreeBody().then(
                            (value) {
                              List<TextEditingController> textControllerList =
                                  [];

                              for (var i = 0; i < value.length; i++) {
                                textControllerList.add(TextEditingController());
                              }

                              context.pushNamed(
                                PAGES.requestDegree.screenName,
                                extra: [
                                  value,
                                  textControllerList,
                                ],
                              );
                            },
                          );
                        },
                );
              },
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: calculateFontSize(
                  context,
                  smallText,
                ),
                color: ColorsConst.textColor,
              ),
            ),
            const SizedBox(
              height: gap / 2,
            ),
          ],
        );
      },
    );
  }
}
