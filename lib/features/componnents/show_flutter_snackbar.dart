import 'package:flutter/material.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:hr_manegement/my_app.dart';

import '../../core/app_colors.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showFlutterSnackBar({
  required String message,
  Color toastColor = AppColors.green,
}) {
  return ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: AppTextStyle.body.copyWith(color: Colors.white),
      ),
      backgroundColor: toastColor,
    ),
  );
}
