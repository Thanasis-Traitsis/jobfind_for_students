// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/list_is_empty_message.dart';
import '../../../auth/presentation/widgets/applicants_card/applicants_card.dart';
import '../applicants_list_bloc/applicants_list_bloc.dart';

class ApplicantsListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const ApplicantsListScreen({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Αιτήσεις',
          style: TextStyle(
            fontSize: calculateFontSize(
              context,
              veryLargeText,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top : padding),
          child: BlocBuilder<ApplicantsListBloc, ApplicantsListState>(
              builder: (context, state) {
            if (state is ApplicantsListEmpty) {
              return Container(
                padding: const EdgeInsets.all(padding),
                child: ListIsEmptyMessage(
                  context: context,
                  text: 'Δεν υπάρχνουν αιτήσεις για τη συγκεκριμένη αγγελία.',
                ),
              );
            }
        
            if (state is ApplicantsListNotEmpty) {
              list = state.applicantsList;
        
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ApplicantsCard(
                    context: context,
                    list: list[index],
                    applicantsForOneJob: true,
                  );
                },
                itemCount: list.length,
              );
            }
            return CustomLoading(
              ColorsConst.primaryColor,
            );
          }),
        ),
      ),
    );
  }
}
