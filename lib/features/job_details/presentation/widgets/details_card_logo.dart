import 'package:flutter/material.dart';

import '../../../../core/constants/styles.dart';
import '../../../auth/presentation/widgets/big_job_card/company_logo_container.dart';
import '../../../listings/data/models/job_model.dart';

Widget DetailsCardLogo({
  required BuildContext context,
  required JobModel job,
}) {
  return Column(
    children: [
      const SizedBox(
        height: gap / 2,
      ),
      CompanyLogoContainer(
        isCard: false,
        imgUrl: job.avatar_path,
        company: job.companyName!,
        context: context,
      ),
      const SizedBox(
        height: gap / 2,
      ),
    ],
  );
}
