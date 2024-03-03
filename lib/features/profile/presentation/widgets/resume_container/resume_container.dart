// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/constants/values.dart';
import '../../../../../core/usecases/calculate_font_size.dart';
import '../../../../../core/utils/scaffold_message.dart';
import '../../../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../../../domain/usecases/download_open_file.dart';
import '../../resume_bloc/resume_bloc.dart';
import 'resume_button.dart';
import 'resume_card.dart';

class ResumeContainer extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const ResumeContainer({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ResumeBloc>(context).add(
      InitialResumeState(),
    );

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String? resumePath;

        if (state is AuthAuthenticated) {
          resumePath = state.user!.resume_path;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<ResumeBloc, ResumeState>(
                  listener: (context, state) {
                    if (state is ResumeFailure) {
                      scaffoldMessengerKey.currentState?.showSnackBar(
                        ScaffoldMessage(
                          context: context,
                          isWarning: true,
                          message: state.message,
                          onTap: () {
                            scaffoldMessengerKey.currentState
                                ?.hideCurrentSnackBar();
                          },
                        ),
                      );
                    }
                    if (state is ResumeSuccess) {
                      resumePath = state.resume;

                      scaffoldMessengerKey.currentState?.showSnackBar(
                        ScaffoldMessage(
                          context: context,
                          message: state.message,
                          onTap: () {
                            scaffoldMessengerKey.currentState
                                ?.hideCurrentSnackBar();
                          },
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ResumeCard(
                      context: context,
                      isLoading: state is ResumeLoading ? true : false,
                      isSuccess: state is ResumeSuccess ? true : false,
                      onPressed: state is ResumeLoading
                          ? () => null
                          : () async {
                              var url = '$publicUrl$resumePath';
                              var fileName = 'resume.pdf';

                              if (resumePath != null) {
                                DownLoadOpenFile().openFile(
                                  url: url,
                                  fileName: fileName,
                                );
                              } else {
                                scaffoldMessengerKey.currentState?.showSnackBar(
                                  ScaffoldMessage(
                                    context: context,
                                    message:
                                        'Δεν έχετε προσθέσει κάποιο βιογραφικό σημείωμα στο λογαριασμό.',
                                    onTap: () {
                                      scaffoldMessengerKey.currentState
                                          ?.hideCurrentSnackBar();
                                    },
                                  ),
                                );
                              }

                              BlocProvider.of<ResumeBloc>(context).add(
                                InitialResumeState(),
                              );
                            },
                    );
                  },
                ),
                const SizedBox(
                  width: gap / 2,
                ),
                ResumeButton(
                  context: context,
                  scaffoldMessengerKey: scaffoldMessengerKey,
                ),
              ],
            ),
            Text(
              'Ανεβάστε αρχείο .pdf, .doc ή .docx. Αποδεκτό μέγεθος αρχείου εώς και $resumeFileMB MB.',
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
