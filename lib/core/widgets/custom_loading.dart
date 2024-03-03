import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomLoading(Color color) {
  return Center(
    child: Platform.isIOS
        ? CupertinoActivityIndicator(
            color: color,
          )
        : CircularProgressIndicator(
            strokeWidth: 3,
            color: color,
          ),
  );
}
