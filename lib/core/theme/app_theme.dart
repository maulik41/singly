import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'Poppins',
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    iconTheme: IconThemeData(color: AppColors.black),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(fontSize: 12),
  ),
);
