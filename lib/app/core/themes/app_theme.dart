import 'package:flutter/material.dart';

var primaryColor = const Color(0xFFFCEE57);
var backgroundColor = const Color(0xFF101010);
var gray = const Color(0xFF292929);

class AppTheme {
  static final ThemeData theme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    backgroundColor: gray,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      backgroundColor: backgroundColor,
      shadowColor: gray,
      elevation: 1,
    ),
  );
}
