import 'package:hr_manegement/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/di/di.dart';

import 'storage/local/app_prefs.dart';
import 'app_colors.dart';
import 'text_style.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backGroundLight,
    fontFamily: getIt<AppPreferences>().font,
    fontFamilyFallback: const [Constants.arFont, Constants.enFont],
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.primaryDark,
    disabledColor: AppColors.darkGrey,

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.backGroundLight2,
      elevation: 0,
      selectedIconTheme: IconThemeData(color: AppColors.primary),
    ),
    cardTheme: const CardThemeData(
      color: AppColors.backGroundLight2,
      shadowColor: AppColors.grey,
      elevation: 4,
      clipBehavior: Clip.hardEdge,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.backGroundLight2,
      shadowColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: AppTextStyle.subTitle.copyWith(
        color: AppColors.textMainLight,
        fontFamily: getIt<AppPreferences>().font,
      ),
    ),
    // button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: AppColors.darkGrey,
      buttonColor: AppColors.primary,
      splashColor: AppColors.primaryLight,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTextStyle.title.copyWith(
          color: AppColors.textMainLight,
          fontFamily: getIt<AppPreferences>().font,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(8),
      hintStyle: TextStyle(color: AppColors.grey),
      labelStyle: TextStyle(color: AppColors.textMainLight),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.grey),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),

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
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(AppColors.primary),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backGroundDark,
    fontFamily: getIt<AppPreferences>().font,
    fontFamilyFallback: const [Constants.arFont, Constants.enFont],
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.primaryDark,
    disabledColor: AppColors.darkGrey,

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.backGroundDark2,
      elevation: 0,
      selectedIconTheme: IconThemeData(color: AppColors.primary),
    ),
    cardTheme: const CardThemeData(
      color: AppColors.backGroundDark2,
      shadowColor: AppColors.black,
      elevation: 4,
      clipBehavior: Clip.hardEdge,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.backGroundDark2,
      shadowColor: AppColors.black,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: AppTextStyle.subTitle.copyWith(
        color: AppColors.textMainDark,
        fontFamily: getIt<AppPreferences>().font,
      ),
    ),
    // button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: AppColors.darkGrey,
      buttonColor: AppColors.primary,
      splashColor: AppColors.primaryLight,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTextStyle.title.copyWith(
          color: AppColors.textMainDark,
          fontFamily: getIt<AppPreferences>().font,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(8),
      hintStyle: TextStyle(color: AppColors.grey),
      labelStyle: TextStyle(color: AppColors.textMainDark),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkGrey),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.grey),
      trackColor: WidgetStateProperty.all(AppColors.primary),
      overlayColor: WidgetStateProperty.all(AppColors.grey),
      trackOutlineColor: WidgetStateProperty.all(AppColors.primary),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(AppColors.primary),
      fillColor: WidgetStateProperty.all(AppColors.backGroundDark2),
      side: const BorderSide(color: AppColors.primary),
      overlayColor: WidgetStateProperty.all(AppColors.primary),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(AppColors.primary),
    ),
  );
}
