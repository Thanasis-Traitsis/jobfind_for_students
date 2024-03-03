import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/constants/values.dart';
import '../../../../../core/usecases/calculate_font_size.dart';
import '../../../../../core/utils/scaffold_message.dart';
import '../../resume_bloc/resume_bloc.dart';

Widget ResumeButton({
  required BuildContext context,
  required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
}) {
  return Container(
    decoration: BoxDecoration(
      color: ColorsConst.highlightColor,
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
        onTap: () async {
          final result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf', 'docx', 'doc'],
          );

          if (result == null) return;

          final file = result.files.first;
          double fileSize = file.size / (1024 * 1024);

          if (fileSize > resumeFileMB) {
            scaffoldMessengerKey.currentState?.showSnackBar(
              ScaffoldMessage(
                context: context,
                isWarning: true,
                message: 'Το αρχείο υπερβαίνει το όριο των $resumeFileMB MB!',
                onTap: () {
                  scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
                },
              ),
            );

            return;
          } else {
            final filePath = File(result.files.single.path!);
            BlocProvider.of<ResumeBloc>(context).add(
              UploadResumeButtonPressed(
                resume: filePath,
              ),
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Icon(
            FontAwesomeIcons.plus,
            color: ColorsConst.white,
            size: calculateFontSize(
              context,
              30,
            ),
          ),
        ),
      ),
    ),
  );
}
