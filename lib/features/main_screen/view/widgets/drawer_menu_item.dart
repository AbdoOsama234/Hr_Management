import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

class DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isDark;
  final Color? iconColor;

  /// أيقونة إضافية يمين (زي زرار الدارك مود)
  final IconData? trailingIcon;

  const DrawerMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isDark,
    this.onTap,
    this.iconColor,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor =
    isDark ? AppColors.textMain : const Color(0xFF1A1A2E);

    final Color itemIconColor =
        iconColor ?? AppColors.primary;

    return InkWell(
      onTap: onTap,
      highlightColor: AppColors.primary.withOpacity(0.05),
      splashColor: AppColors.primary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
        child: Row(
          children: [

            /// Icon container
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: itemIconColor.withOpacity(isDark ? 0.12 : 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: itemIconColor,
                size: 5.5.w,
              ),
            ),

            SizedBox(width: 4.w),

            /// Title
            Text(
              title,
              style: AppTextStyle.body.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),

            const Spacer(),

            /// trailing icon (مثلاً للدارك مود)
            if (trailingIcon != null)
              Icon(
                trailingIcon,
                color: AppColors.primary,
                size: 5.w,
              )
            else
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: isDark ? Colors.white24 : Colors.black12,
                size: 3.5.w,
              ),
          ],
        ),
      ),
    );
  }
}