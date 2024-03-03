import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../favourite/presentation/favourite_bloc/favourite_bloc.dart';

void updateFavouriteStatus({
  int? listLength,
  int? beforeChange,
  required BuildContext context,
  required List list,
  required String id,
  required bool isFav,
}) {
  if (listLength != null && beforeChange != null) {
    if (((listLength == 0 || listLength == 1) && beforeChange <= 1)) {
      BlocProvider.of<FavouriteBloc>(context).add(
        GetFavouriteJobs(),
      );
    }
  }

  bool jobIdExistsInList = false;

  for (var element in list) {
    if (element.id.toString() == id) {
      jobIdExistsInList = true;
      break;
    }
  }

  if (jobIdExistsInList) {
    list[list.indexWhere((element) => element.id.toString() == id)]
        .isFavourite = isFav ? 1 : 0;
  }
}
