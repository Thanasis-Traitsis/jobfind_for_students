import 'package:flutter/material.dart';

Widget ImageContainer({bool isLandscape = false}) {
  return SizedBox(
    height: 80,
    width: double.infinity,
    child: isLandscape
        ? Image.asset('assets/images/logo-white.png')
        : Image.asset('assets/images/logo-blue.png'),
  );
}
