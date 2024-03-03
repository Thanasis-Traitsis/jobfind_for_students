import 'package:flutter/material.dart';

Widget ScreenContainer({
  required Widget child,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,),
    child: child,
  );
}
