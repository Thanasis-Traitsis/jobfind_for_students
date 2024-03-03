import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../listings/data/models/job_model.dart';
import '../job_details_bloc/job_details_bloc.dart';
import 'header_button.dart';

Widget MoreTextContainer({
  required JobModel job,
  required Function function,
  bool noNeedBottomSpace = false,
}) {
  return BlocBuilder<JobDetailsBloc, JobDetailsState>(
    builder: (context, state) {
      var chosen = state is JobDetailsParagraphSection
          ? state.paragraph
          : job.description!;

      return Column(
        children: [
          Row(
            children: [
              HeaderButton(
                context: context,
                text: 'Περιγραφή',
                function: () {
                  chosen != job.description ? function(job.description) : null;
                },
                isClicked: state is JobDetailsParagraphSection
                    ? state.paragraph == job.description
                    : false,
              ),
              const SizedBox(
                width: 5,
              ),
              HeaderButton(
                context: context,
                text: 'Προσόντα',
                function: () {
                  chosen != job.requirements
                      ? function(job.requirements)
                      : null;
                },
                isClicked: state is JobDetailsParagraphSection
                    ? state.paragraph == job.requirements
                    : false,
              ),
              const SizedBox(
                width: 5,
              ),
              HeaderButton(
                context: context,
                text: 'Εταιρεία',
                function: () {
                  chosen != job.company_description
                      ? function(job.company_description)
                      : null;
                },
                isClicked: state is JobDetailsParagraphSection
                    ? state.paragraph == job.company_description
                    : false,
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              top: gap,
            ),
            padding: EdgeInsets.only(
              bottom: ((padding * 2) +
                  (noNeedBottomSpace ? 0 : floatingButtonHeight)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: gap / 2),
                  child: Text(
                    chosen == job.requirements
                        ? 'Απαραίτητα Προσόντα'
                        : chosen == job.company_description
                            ? 'Στοιχεία Εταιρείας'
                            : 'Αναλυτική Περιγραφή',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorsConst.textColor,
                      fontSize: calculateFontSize(
                        context,
                        largeText,
                      ),
                    ),
                  ),
                ),
                Html(
                  data: state is JobDetailsParagraphSection
                      ? state.paragraph
                      : job.description!,
                  style: {
                    "html": Style(
                      padding: HtmlPaddings.all(0),
                      margin: Margins.all(0),
                      color: ColorsConst.textColor,
                      fontSize: FontSize(
                        calculateFontSize(
                          context,
                          normalText,
                        ),
                      ),
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
