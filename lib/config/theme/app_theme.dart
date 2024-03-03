import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData(
    fontFamily: 'Manrope',
    primarySwatch: ColorsConst.primarySwatch,
    canvasColor: ColorsConst.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
    ),
    colorScheme: ColorScheme.light(
      background: ColorsConst.white,
      primary: ColorsConst.primaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsConst.primaryColor,
      foregroundColor: ColorsConst.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsConst.highlightColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(ColorsConst.highlightColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    ),
  );
}
