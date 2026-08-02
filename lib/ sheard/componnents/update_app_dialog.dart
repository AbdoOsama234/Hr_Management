import 'dart:io';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UpdateAppDialog extends StatelessWidget {
  final String? latestVersion;
  final VoidCallback onUpdatePressed;

  const UpdateAppDialog({
    super.key,
    this.latestVersion,
    required this.onUpdatePressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: screenWidth * 0.85, // 85% من عرض الشاشة
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxHeight: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.system_update,
                  size: 60,
                  color: AppColors.white,
                ),
              ),
              AppSizedBox.h3,
              // Title
              Text(
                'update_required'.tr(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              AppSizedBox.h3,
              // Description
              Text(
                'update_available_message'.tr(),
                style: TextStyle(fontSize: 14.sp, color: AppColors.darkGrey),
                textAlign: TextAlign.center,
              ),
              if (latestVersion != null) ...[
                AppSizedBox.h8,
                Text(
                  "${'latest_version'.tr()}: $latestVersion",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              AppSizedBox.h6,
              // Update Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onUpdatePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Platform.isIOS ? Icons.apple : Icons.android,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'update_now'.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
