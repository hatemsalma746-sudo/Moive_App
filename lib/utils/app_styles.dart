import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static TextStyle descriptions1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Color(0x60FFFFFF),
    fontStyle: FontStyle.normal,
  );
  static TextStyle descriptions = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteColor,
    fontStyle: FontStyle.normal,
  );
  static TextStyle header1 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColor,
  );
  static TextStyle headers = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );
  static TextStyle boardingBottoms = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );
  static TextStyle login = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteColor,
  );

  static TextStyle smallWhiteText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteColor,
  );

  static TextStyle smallYellowText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.yellowColor,
  );
}
