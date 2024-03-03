import 'package:flutter/material.dart';

void updateApplyStatus({
  required BuildContext context,
  required List list,
  required String id,
  required bool hasAppl,
}) {
  bool jobIdExistsInList = false;

  for (var element in list) {
    if (element.id.toString() == id) {
      jobIdExistsInList = true;
      break;
    }
  }

  if (jobIdExistsInList) {
    list[list.indexWhere((element) => element.id.toString() == id)]
        .hasApplied = hasAppl ? 1 : 0;
  }
}
