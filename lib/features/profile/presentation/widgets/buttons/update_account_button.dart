import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/highlight_color_button.dart';
import '../../edit_account_bloc/edit_account_bloc.dart';

Widget UpdateAccountButton({
  required BuildContext context,
  required Function function,
}) {
  return BlocBuilder<EditAccountBloc, EditAccountState>(
    builder: (context, state) {
      return HighlighColorButton(
        onPressed: () {
          function();
        },
        text: 'Ενημέρωση',
        context: context,
        isLoading: state is EditAccountLoading ? true : false,
      );
    },
  );
}
