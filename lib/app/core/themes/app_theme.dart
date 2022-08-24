import 'package:flutter/material.dart';

var primaryColor = const Color(0xFFFCEE57);
var backgroundColor = const Color(0xFF101010);

class AppTheme {
  static final ThemeData theme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      backgroundColor: backgroundColor,
      shadowColor: const Color(0xFF6e6e6e),
      elevation: 1,
    ),
  );
}
