import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/containers.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_font_size.dart';
import 'applicants_avatar.dart';
import 'resume_download_container.dart';

Widget ApplicantsCard({
  required BuildContext context,
  required Map list,
  bool applicantsForOneJob = false,
}) {
  return Container(
    margin: const EdgeInsets.only(
      left: padding,
      right: padding,
      bottom: padding,
    ),
    padding: const EdgeInsets.all(padding),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
      border: Border.all(
        color: ColorsConst.lightgreyColor,
        width: 2,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ApplicantsAvatar(
          context: context,
          imageLink: applicantsForOneJob
              ? list['avatar_path']
              : list['user']['avatar_path'],
          lastNameLetter: applicantsForOneJob
              ? list['last_name'][0]
              : list['user']['last_name'][0],
          firstNameLetter: applicantsForOneJob
              ? list['first_name'][0]
              : list['user']['first_name'][0],
        ),
        const SizedBox(
          width: gap / 2,
        ),
        Expanded(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        applicantsForOneJob
                            ? list['last_name']
                            : list['user']['last_name'],
                        style: TextStyle(
                          color: ColorsConst.textColor,
                          fontSize: calculateFontSize(
                            context,
                            mediumText,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: gap / 3,
                      ),
                      Flexible(
                        child: Text(
                          applicantsForOneJob
                              ? list['first_name']
                              : list['user']['first_name'],
                          style: TextStyle(
                            color: ColorsConst.textColor,
                            fontSize: calculateFontSize(
                              context,
                              mediumText,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    applicantsForOneJob ? list['email'] : list['user']['email'],
                    style: TextStyle(
                      color: ColorsConst.textColor,
                      fontSize: calculateFontSize(
                        context,
                        normalText,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: gap / 2,
                  ),
                  ResumeDownloadContainer(
                    resumePath: applicantsForOneJob
                        ? list['resume_path']
                        : list['user']['resume_path'],
                  ),
                  applicantsForOneJob ? Container() : const Divider(),
                ],
              ),
              applicantsForOneJob
                  ? Container()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Αιτήθηκε για : ',
                          style: TextStyle(
                            color: ColorsConst.textColor,
                            fontSize: calculateFontSize(
                              context,
                              normalText,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            list['listing']['title'],
                            style: TextStyle(
                              color: ColorsConst.textColor,
                              fontSize: calculateFontSize(
                                context,
                                mediumText,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ],
    ),
  );
}
