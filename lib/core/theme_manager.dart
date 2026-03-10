import 'package:flutter/services.dart';
import 'package:hr_manegement/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/di/di.dart';

import '../data/storage/local/app_prefs.dart';
import 'app_colors.dart';
import 'text_style.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backGround,
    fontFamily: getIt<AppPreferences>().font,
    fontFamilyFallback: const [Constants.arFont, Constants.enFont],
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.primaryDark,
    disabledColor: AppColors.darkGrey,
    //splashColor: AppColors.primaryLight,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory, // 🔥 stops ripple
    // ripple effect color
    // cardview theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.backGround2,
      elevation: 0,
      selectedIconTheme: IconThemeData(color: AppColors.primary),
    ),
    cardTheme: const CardThemeData(
      color: AppColors.backGround2,
      shadowColor: AppColors.grey,
      elevation: 4,
      clipBehavior: Clip.hardEdge,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: AppColors.backGround2,
      shadowColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: AppTextStyle.subTitle.copyWith(
        color: AppColors.black,
        fontFamily: getIt<AppPreferences>().font,
      ),
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: Colors.transparent, // status bar background
      //   statusBarIconBrightness: Brightness.light, // Android icons (black)
      //   statusBarBrightness: Brightness.light, // iOS icons (black)
      //   systemNavigationBarColor: AppColors.backGround2,
      //   systemNavigationBarIconBrightness: Brightness.dark,
      // ),
    ),
    // button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: AppColors.darkGrey,
      buttonColor: AppColors.primary,
      splashColor: AppColors.primaryLight,
    ),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTextStyle.title.copyWith(
          color: AppColors.textMain,
          fontFamily: getIt<AppPreferences>().font,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(8),
      // hint style
      hintStyle: AppTextStyle.title,
      labelStyle: AppTextStyle.subTitle,

      // enabled border style
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.grey),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),

      // focused border style
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),

      // error border style
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      // focused border style
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    // label style
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.grey),
      trackColor: WidgetStateProperty.all(AppColors.primary),
      overlayColor: WidgetStateProperty.all(AppColors.grey),
      trackOutlineColor: WidgetStateProperty.all(AppColors.primary),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(AppColors.primary),
      fillColor: WidgetStateProperty.all(AppColors.white),
      side: const BorderSide(color: AppColors.primary),
      overlayColor: WidgetStateProperty.all(AppColors.primary),
      // overlayColor: WidgetStateProperty.all(AppColors.primary),
      // fillColor: WidgetStateProperty.all(AppColors.primary),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(AppColors.primary),
    ),
  );
}

ThemeData darkTheme() => ThemeData();
