import 'package:flutter/material.dart';

abstract final class AppTheme{
  static final ThemeData themeData=ThemeData(
  primaryColor:  Color(0xff121312),
  colorScheme:  ColorScheme.fromSeed(
  seedColor: Color(0xff121312),
  secondary: Color(0xffFFBB3B),
  ),
  textTheme:  TextTheme(
  headlineSmall: TextStyle(
  fontSize: 24,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  ),
  bodyLarge: TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.normal,
  ),
  headlineLarge: TextStyle(
  fontSize: 36,
  color: Colors.white,
  fontWeight: FontWeight.w500,
),
labelLarge: TextStyle(
fontSize: 20,
color: ThemeData().primaryColor,
fontWeight: FontWeight.w600),
labelMedium: TextStyle(
fontSize: 16,
color: ThemeData().colorScheme.secondary,
fontWeight: FontWeight.normal,
),
bodySmall: TextStyle(
fontSize: 14,
color: Colors.white,
fontWeight: FontWeight.normal
),
),
inputDecorationTheme: const InputDecorationTheme(
hintStyle: TextStyle(
fontSize: 16,
fontWeight: FontWeight.normal,
color: Colors.white,
),
)
);
}