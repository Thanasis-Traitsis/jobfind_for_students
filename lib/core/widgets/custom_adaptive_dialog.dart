import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_bloc_ihu/config/theme/colors.dart';

AlertDialog CustomAdaptiveDialog({
  required BuildContext context,
  required String heading,
  required String text,
  required VoidCallback onPressed,
}) {
  return AlertDialog.adaptive(
    title: Text(heading),
    content: Text(text),
    actions: Platform.isIOS
        ? <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Άκυρο'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: onPressed,
              child: const Text('Ναι'),
            ),
          ]
        : <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Άκυρο',
                style: TextStyle(
                  color: ColorsConst.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                'Ναι',
                style: TextStyle(
                  color: ColorsConst.redColor,
                ),
              ),
            ),
          ],
  );
}
