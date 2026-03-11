import 'package:flutter/material.dart';

import '../my_app.dart';

class AppColors {
  static const Color backGroundDark = Color(0xFF131222);
  static const Color backGroundDark2 = Color(0xFF1b1a28);
  static const Color backGroundLight = Color(0xFFF6F7FB);
  static const Color backGroundLight2 = Color(0xFFFFFFFF);

  static const Color textMainDark = Colors.white;
  static const Color textSubDark = Color(0xFFB3B3B3);

  static const Color textMainLight = Color(0xFF1A1A2E);
  static const Color textSubLight = Color(0xFF6A6A8A);
  static Color get backGround =>
      MyApp.isDark ? backGroundDark : backGroundLight;

  static Color get backGround2 =>
      MyApp.isDark ? backGroundDark2 : backGroundLight2;

  static Color get textMain => MyApp.isDark ? textMainDark : textMainLight;
  static Color get textSub => MyApp.isDark ? textSubDark : textSubLight;
  static Color get borderColor => MyApp.isDark
      ? Colors.white.withOpacity(.05)
      : Colors.grey.withOpacity(.12);

  static Color get iconBgColor => MyApp.isDark
      ? Colors.white.withOpacity(0.06)
      : Colors.black.withOpacity(0.05);
  static Color get iconBorderColor => MyApp.isDark
      ? Colors.white.withOpacity(0.08)
      : Colors.black.withOpacity(0.06);
  static Color get shadowColor => MyApp.isDark
      ? Colors.black.withOpacity(0.4)
      : Colors.grey.withOpacity(0.2);
  static Color get dividerColor => MyApp.isDark
      ? AppColors.darkGrey.withOpacity(0.3)
      : Colors.grey.withOpacity(0.15);
  static Color get badgeBorderColor =>
      MyApp.isDark ? const Color(0xFF1e1d2f) : const Color(0xFFEAF0FF);
  static Color get avatarBg =>
      MyApp.isDark ? AppColors.backGround : const Color(0xFFF0F0F5);
  static const Color primaryLight = Color(0xFFC2410C);
  static const Color primaryDark = Color(0xFF8C2D12);
  static const Color primary = Color(0xFFe50014);
  static const List<Color> headerGradientDark = [
    Color(0xFF1e1d2f),
    Color(0xFF28273d),
    Color(0xFF1e1d2f),
  ];
  static const List<Color> headerGradientLight = [
    Color(0xFFEAF0FF),
    Color(0xFFDDE6FF),
    Color(0xFFEAF0FF),
  ];
  static LinearGradient get primaryGradient => MyApp.isDark
      ? LinearGradient(
          colors: headerGradientDark,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      : LinearGradient(
          colors: headerGradientLight,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

  static const Color darkGrey = Color(0xff6E6A7C);
  static const Color lightgrey = Color(0xffa5a5a5);
  static const Color grey = Color(0xff7F7F7F);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color filler = Color(0xfff2f2f2);
  static const Color yellow = Colors.yellow;
  static const Color border = Color(0xffFDE2D7);
  static const Color green = Color(0xff0EAB00);
  static const Color deepPurple = Colors.deepPurple;
  static const Color red = Color(0xffAB0000);
  static const Color darkBlue = Color(0xff182775);
  static const Color hintText = Color(0xffBABABA);
  static const Color unSelectedNav = Color(0xffD1D1D1);
  static const Color iconBackGround = Color(0xffFAF8F6);
  static const Color fillerBackGround = Color(0xffFAF8F6);
  static const Color textFieldHint = Color(0xff373948);

  // new colors
  static const Color orange = Color(0xffFF7D53);
  static const Color blue = Color(0xff0087FF); // color with 80% opacity
  static const Color error = red; // red color
}
