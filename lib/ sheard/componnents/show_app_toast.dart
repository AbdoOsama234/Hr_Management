import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';

import '../../my_app.dart';

enum ToastType { success, error, info }

class CustomToast {
  CustomToast._();

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

  static void show({
    required String message,
    ToastType type = ToastType.success,
    Duration duration = const Duration(seconds: 2),
  }) {
    final overlay = navigatorKey.currentState!.overlay!;
    late OverlayEntry entry;
    final color = _getColor(type);

    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        left: 20,
        right: 20,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) => Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, (1 - value) * 20),
              child: child,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.2),
                        blurRadius: 20,
                        spreadRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_getIcon(type), color: color, size: 22),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textMain,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    Timer(duration, () {
      if (entry.mounted) {
        entry.remove();
      }
    });
  }
}
