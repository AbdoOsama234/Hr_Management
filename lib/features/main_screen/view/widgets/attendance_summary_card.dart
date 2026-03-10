  import 'package:flutter/material.dart';
  import 'package:easy_localization/easy_localization.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:hr_manegement/core/app_colors.dart';
  import 'package:hr_manegement/core/app_cubit/app_cubit.dart';
  import 'package:hr_manegement/core/app_sized_box.dart';
  import 'package:hr_manegement/core/extensions.dart';
  import 'package:hr_manegement/core/text_style.dart';

  class AttendanceSummaryCard extends StatelessWidget {
    final int presentDays;
    final int leaveDays;
    final double allowedLateHours;

    const AttendanceSummaryCard({
      super.key,
      required this.presentDays,
      required this.leaveDays,
      required this.allowedLateHours,
    });

    @override
    Widget build(BuildContext context) {
      final isDark = context.read<AppCubit>().isDark;

      final Color cardBg = isDark
          ? AppColors.backGround2
          : const Color(0xFFFFFFFF);
      final Color borderColor = isDark
          ? Colors.white.withOpacity(0.05)
          : Colors.grey.withOpacity(0.12);
      final Color shadowColor = isDark
          ? Colors.black.withOpacity(0.3)
          : Colors.grey.withOpacity(0.15);
      final Color textColor = isDark
          ? AppColors.textMain
          : const Color(0xFF1A1A2E);
      final Color subtextColor = isDark
          ? AppColors.textSub
          : const Color(0xFF6A6A8A);
      final Color dividerColor = isDark
          ? AppColors.darkGrey.withOpacity(0.3)
          : Colors.grey.withOpacity(0.15);
      final Color iconTitleBg = isDark
          ? AppColors.primary.withOpacity(0.12)
          : AppColors.primary.withOpacity(0.08);

      return AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.h),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Section Title
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: iconTitleBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.primary,
                    size: 5.w,
                  ),
                ),
                SizedBox(width: 2.5.w),
                Expanded(
                  child: Text(
                    'monthly_attendance_summary'.tr(),
                    maxLines: 2,
                    style: AppTextStyle.title.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w700,

                    ),
                  ),
                ),
              ],
            ),
            AppSizedBox.h2,

            /// Stats Row
            Row(
              children: [
                _buildStatItem(
                  icon: Icons.check_circle_rounded,
                  iconColor: AppColors.green,
                  label: 'attendance'.tr(),
                  value: '$presentDays',
                  valueSuffix: 'day'.tr(),
                  textColor: textColor,
                  subtextColor: subtextColor,
                  isDark: isDark,
                ),
                _buildDivider(dividerColor),
                _buildStatItem(
                  icon: Icons.beach_access_rounded,
                  iconColor: AppColors.orange,
                  label: 'leaves'.tr(),
                  value: '$leaveDays',
                  valueSuffix: 'days'.tr(),
                  textColor: textColor,
                  subtextColor: subtextColor,
                  isDark: isDark,
                ),
                _buildDivider(dividerColor),
                _buildStatItem(
                  icon: Icons.schedule_rounded,
                  iconColor: AppColors.blue,
                  label: 'late_limit'.tr(),
                  value: '${allowedLateHours.toInt()}',
                  valueSuffix: 'hours'.tr(),
                  textColor: textColor,
                  subtextColor: subtextColor,
                  isDark: isDark,
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildStatItem({
      required IconData icon,
      required Color iconColor,
      required String label,
      required String value,
      required String valueSuffix,
      required Color textColor,
      required Color subtextColor,
      required bool isDark,
    }) {
      return Expanded(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(isDark ? 0.1 : 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 5.5.w),
            ),
            SizedBox(height: 1.h),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: AppTextStyle.subHeadline.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: valueSuffix,
                    style: AppTextStyle.smallBody.copyWith(color: subtextColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: AppTextStyle.smallBody.copyWith(
                color: subtextColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget _buildDivider(Color dividerColor) {
      return Container(
        width: 1,
        height: 8.h,
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, dividerColor, Colors.transparent],
          ),
        ),
      );
    }
  }
