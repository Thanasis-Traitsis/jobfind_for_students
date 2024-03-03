import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/highlight_color_button.dart';
import '../../request_degree_bloc/request_degree_bloc.dart';

Widget RequestDegreeButton({
  required BuildContext context,
  required Function function,
}) {
  return BlocBuilder<RequestDegreeBloc, RequestDegreeState>(
    builder: (context, state) {
      return HighlighColorButton(
        onPressed: () {
          function();
        },
        text: 'Υποβολή Αίτησης',
        context: context,
        isLoading: state is RequestDegreeLoading ? true : false,
      );
    },
  );
}
