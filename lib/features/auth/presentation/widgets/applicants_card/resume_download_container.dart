// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/usecases/calculate_font_size.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../../../profile/domain/usecases/download_open_file.dart';

class ResumeDownloadContainer extends StatefulWidget {
  final String? resumePath;

  const ResumeDownloadContainer({
    Key? key,
    required this.resumePath,
  }) : super(key: key);

  @override
  State<ResumeDownloadContainer> createState() =>
      _ResumeDownloadContainerState();
}

class _ResumeDownloadContainerState extends State<ResumeDownloadContainer> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            setState(() {
              isLoading = true;
            });

            var url = '$publicUrl${widget.resumePath}';
            var fileName = 'resume.pdf';

            DownLoadOpenFile()
                .openFile(
              url: url,
              fileName: fileName,
            )
                .then((_) {
              setState(() {
                isLoading = false;
              });
            });
          },
          child: Row(
            children: [
              Text(
                'Βιογραφικό',
                style: TextStyle(
                  color: ColorsConst.highlightColor,
                  fontSize: calculateFontSize(
                    context,
                    mediumText,
                  ),
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                FontAwesomeIcons.fileArrowDown,
                size: calculateFontSize(
                  context,
                  20,
                ),
                color: ColorsConst.highlightColor,
              )
            ],
          ),
        ),
        isLoading
            ? SizedBox(
                height: calculateFontSize(context, 30),
                width: calculateFontSize(context, 30),
                child: Transform.scale(
                  scale: .8,
                  child: CustomLoading(
                    ColorsConst.primaryColor,
                  ),
                ),
              )
            : SizedBox(
                height: calculateFontSize(context, 30),
                child: Container(),
              ),
      ],
    );
  }
}
