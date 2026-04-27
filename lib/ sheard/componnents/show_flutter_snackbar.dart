import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/text_style.dart';
import '../../my_app.dart';

enum ToastType { success, error, info }

class AppSnackBar {
  AppSnackBar._();

  static Color _getColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return AppColors.green;
      case ToastType.error:
        return AppColors.red;
      case ToastType.info:
        return AppColors.primary;
    }
  }

  static IconData _getIcon(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle_outline;
      case ToastType.error:
        return Icons.error_outline;
      case ToastType.info:
        return Icons.info_outline;
    }
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show({
    required String message,
    ToastType type = ToastType.success,
  }) {
    final color = _getColor(type);

    final context = navigatorKey.currentState!.context;

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            Icon(_getIcon(type), color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: AppTextStyle.body.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void hideCurrent() {
    final context = navigatorKey.currentState!.context;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static void clearAll() {
    final context = navigatorKey.currentState!.context;
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
