import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

class BranchCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const BranchCard({
    super.key,
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.backGround2,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Icon with circular background
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 8.w,
              ),
            ),
            SizedBox(height: 2.h),

            /// Branch Name
            Text(
              name.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyle.title.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 1.h),

            /// Subtitle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "view_employees".tr(),
                  style: AppTextStyle.smallBody.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 1.w),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 3.w,
                  color: AppColors.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
