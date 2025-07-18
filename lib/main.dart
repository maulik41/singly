import 'package:flutter/material.dart';
import 'package:singly/core/constants/app_constants.dart';
import 'package:singly/core/theme/app_theme.dart';
import 'package:singly/core/theme/app_theme_dark.dart';
import 'package:singly/core/routes/app_routes.dart';

void main() {
  runApp(const SinglyApp());
}

class SinglyApp extends StatelessWidget {
  const SinglyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: appTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.onboarding,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
