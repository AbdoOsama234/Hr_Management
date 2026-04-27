import 'package:flutter/material.dart';
import '../my_app.dart';

class AppColors {
  // 🌑 Backgrounds
  static const Color backGroundDark = Color(0xFF0B0B0B);
  static const Color backGroundDark2 = Color(0xFF151515);

  static const Color backGroundLight = Color(0xFFF6F7FB);
  static const Color backGroundLight2 = Color(0xFFFFFFFF);

  // 📝 Text
  static const Color textMainDark = Color(0xFFFFFFFF);
  static const Color textSubDark = Color(0xFFB0B0B0);

  static const Color textMainLight = Color(0xFF1A1A2E);
  static const Color textSubLight = Color(0xFF6A6A8A);

  static Color get backGround =>
      MyApp.isDark ? backGroundDark : backGroundLight;

  static Color get backGround2 =>
      MyApp.isDark ? backGroundDark2 : backGroundLight2;

  static Color get textMain => MyApp.isDark ? textMainDark : textMainLight;

  static Color get textSub => MyApp.isDark ? textSubDark : textSubLight;

  // 🧱 Borders & Dividers
  static Color get borderColor => MyApp.isDark
      ? Colors.white.withOpacity(.06)
      : Colors.grey.withOpacity(.12);

  static Color get dividerColor => MyApp.isDark
      ? Colors.white.withOpacity(0.08)
      : Colors.grey.withOpacity(0.15);

  // 🎯 Icons
  static Color get iconBgColor => MyApp.isDark
      ? Colors.white.withOpacity(0.08)
      : Colors.black.withOpacity(0.1);

  static Color get iconBorderColor => MyApp.isDark
      ? Colors.white.withOpacity(0.06)
      : Colors.black.withOpacity(0.06);

  // 🌫 Shadows
  static Color get shadowColor => MyApp.isDark
      ? Colors.black.withOpacity(0.6)
      : Colors.grey.withOpacity(0.2);

  // 🧩 Misc
  static Color get badgeBorderColor =>
      MyApp.isDark ? const Color(0xFF1C1C1E) : const Color(0xFFEAF0FF);

  static Color get avatarBg =>
      MyApp.isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF0F0F5);

  // 💜 Primary Colors (UPDATED)
  static const Color primary = Color(0xFFce6fd4);
  static const Color primaryDark = Color(0xFFA24FC0);
  static const Color primaryLight = Color(0xFFD8A4E8);

  // 🌈 Gradients (هادي ومش مزعج)
  static const List<Color> headerGradientDark = [
    Color(0xFF1A1A1A),
    Color(0xFF221A2A), // hint بنفسجي خفيف
    Color(0xFF2A2A2A),
  ];

  static const List<Color> headerGradientLight = [
    Color(0xFFF3E8FF),
    Color(0xFFE9D5FF),
    Color(0xFFF5F0FF),
  ];

  static LinearGradient get primaryGradient => MyApp.isDark
      ? const LinearGradient(
          colors: headerGradientDark,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      : const LinearGradient(
          colors: headerGradientLight,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

  // 🎨 Extra Colors
  static const Color darkGrey = Color(0xff6E6A7C);
  static const Color lightgrey = Color(0xffa5a5a5);
  static const Color grey = Color(0xff7F7F7F);

  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffFFFFFF);

  static const Color filler = Color(0xfff2f2f2);

  static const Color yellow = Colors.yellow;

  // 💜 border مناسب للون الجديد
  static const Color border = Color(0xFFE9D5FF);

  // static const Color green = Color(0xff68f7eb);
  static Color get mintGreen =>
      MyApp.isDark ? const Color(0xff68f7eb) : const Color(0xFF14afa2);

  // 💜 بدل deepPurple الافتراضي
  static const Color deepPurple = Color(0xFFC362D8);

  static const Color rose = Color(0xffbf5a6b);

  static const Color darkBlue = Color(0xff182775);

  static const Color hintText = Color(0xffBABABA);

  static const Color unSelectedNav = Color(0xff888888);

  static const Color iconBackGround = Color(0xff1C1C1E);

  static const Color fillerBackGround = Color(0xff1C1C1E);

  static const Color textFieldHint = Color(0xff8E8E93);

  static Color get shimmerGradientColorStart =>
      MyApp.isDark ? Color(0xff333639) : Colors.grey.shade300;

  static Color get shimmerGradientColorEnd => MyApp.isDark
      ? Color(0xff333639).withValues(alpha: 0.3)
      : Colors.grey.shade100;

  // 🎯 Accent
  static const Color orange = Color(0xFFFF9800);

  static const Color blue = Color(0xff0087FF);
  static const Color green = Colors.green;
  static const Color red = Colors.red;
}
