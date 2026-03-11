import 'package:flutter/material.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/core/storage/local/app_prefs.dart';

import 'app_colors.dart';
import 'extensions.dart';

class AppTextStyle {
  static TextStyle get headline => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textMain,
    fontFamily: getIt<AppPreferences>().lang == 'ar' ? 'Alexandria' : 'Poppins',
  );

  static TextStyle get subHeadline => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textMain,
    fontFamily: getIt<AppPreferences>().lang == 'ar' ? 'Alexandria' : 'Poppins',
  );
  static TextStyle get smallHeadline => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textMain,
    fontFamily: getIt<AppPreferences>().lang == 'ar' ? 'Alexandria' : 'Poppins',
  );
  static TextStyle get title => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textMain,
    fontFamily: getIt<AppPreferences>().lang == 'ar' ? 'Alexandria' : 'Poppins',
  );

  static TextStyle get subTitle => TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textMain,
    fontFamily: getIt<AppPreferences>().lang == 'ar' ? 'Alexandria' : 'Poppins',
  );

  static TextStyle get body => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSub,
    fontFamily: getIt<AppPreferences>().lang == 'ar' ? 'Alexandria' : 'Poppins',
  );

  static TextStyle get subBody => TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSub,
    fontFamily: getIt<AppPreferences>().lang == 'ar' ? 'Alexandria' : 'Poppins',
  );
  static TextStyle get smallBody => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSub,
    fontFamily: getIt<AppPreferences>().lang == 'ar' ? 'Alexandria' : 'Poppins',
  );

  static TextStyle get hint => TextStyle(
    fontSize: 9.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.hintText,
    fontFamily: getIt<AppPreferences>().lang == 'ar' ? 'Alexandria' : 'Poppins',
  );

  static TextStyle get subHint => TextStyle(
    fontSize: 8.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.hintText,
    fontFamily: getIt<AppPreferences>().lang == 'ar' ? 'Alexandria' : 'Poppins',
  );
  static TextStyle get smallHint => TextStyle(
    fontSize: 7.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.hintText,
    fontFamily: getIt<AppPreferences>().lang == 'ar' ? 'Alexandria' : 'Poppins',
  );
  static TextStyle get button => TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: getIt<AppPreferences>().lang == 'ar' ? 'Alexandria' : 'Poppins',
  );

  static TextStyle getTextStyle(
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  ) {
    return TextStyle(
      fontSize: fontSize ?? 14.sp,
      color: color ?? AppColors.black,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}
