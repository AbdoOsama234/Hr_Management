import 'package:flutter/material.dart';

class AppColors {
  // static const Color backGround = Color(0xFF101010);
  // static const Color backGround2 = Color(0xFF1A1A1A);
  static const Color backGround = Color(0xFF131222);
  static const Color backGround2 = Color(0xFF1b1a28);

  static const Color textMain = Colors.white;
  static const Color textSub = Color(0xFFB3B3B3);

  static const Color primaryLight = Color(0xFFC2410C);
  static const Color primaryDark = Color(0xFF8C2D12);
  static const Color primary = Color(0xFFe50014);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLight, primaryDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
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
