import 'package:flutter/material.dart';
import 'package:moive_app/utils/app_colors.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: AppColors.blackColor,
    appBarTheme: AppTheme(),
    primaryColor: AppColors.blackColor,
  );
}