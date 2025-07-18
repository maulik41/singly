import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
    bodySmall: TextStyle(fontSize: 12, color: Colors.white60),
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    surface: Colors.black,
    onPrimary: Colors.white,
  ),
);
