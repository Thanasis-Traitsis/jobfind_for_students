import 'package:flutter/material.dart';

void updateViewsStatus({
  required BuildContext context,
  required List list,
  required String id,
  required bool hasViewed,
  required int views,
}) {
  bool jobIdExistsInList = false;

  for (var element in list) {
    if (element.id.toString() == id) {
      jobIdExistsInList = true;
      break;
    }
  }

  if (jobIdExistsInList) {
    list[list.indexWhere((element) => element.id.toString() == id)].hasViewed =
        hasViewed ? 1 : 0;

    list[list.indexWhere((element) => element.id.toString() == id)].views =
        hasViewed ? (views + 1).toString() : views.toString();
  }
}
