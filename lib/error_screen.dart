import 'package:flutter/material.dart';

import 'core/constants/font_size.dart';
import 'core/usecases/calculate_font_size.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'ERROR 404',
          style: TextStyle(
            fontSize: calculateFontSize(
              context,
              largeText,
            ),
          ),
        ),
      ),
    );
  }
}
