import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_cubit/app_cubit.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:hr_manegement/data/models/daily_work_log.dart';

class WeeklyReportList extends StatelessWidget {
  final List<DailyWorkLog> logs;

  const WeeklyReportList({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<AppCubit>().isDark;

    final Color textColor = isDark
        ? AppColors.textMain
        : const Color(0xFF1A1A2E);
    final Color iconTitleBg = isDark
        ? AppColors.blue.withOpacity(0.12)
        : AppColors.blue.withOpacity(0.08);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Header
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: iconTitleBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.assignment_outlined,
                color: AppColors.blue,
                size: 5.w,
              ),
            ),
            SizedBox(width: 2.5.w),
            Text(
              'تقارير الأسبوع',
              style: AppTextStyle.title.copyWith(
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.5.h),

        /// Log Items
        ...logs.map((log) => _buildLogItem(log, isDark)),
      ],
    );
  }

  Widget _buildLogItem(DailyWorkLog log, bool isDark) {
    final bool isLate = log.lateMinutes != '0m';

    final Color cardBg = isDark
        ? AppColors.backGround2
        : const Color(0xFFFFFFFF);
    final Color borderColor = isLate
        ? AppColors.orange.withOpacity(0.15)
        : (isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.grey.withOpacity(0.12));
    final Color shadowColor = isDark
        ? Colors.black.withOpacity(0.2)
        : Colors.grey.withOpacity(0.1);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(bottom: 1.2.h),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Day name row
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(isDark ? 0.1 : 0.07),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  log.day,
                  style: AppTextStyle.body.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              if (isLate)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.5.w,
                    vertical: 0.3.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.orange.withOpacity(isDark ? 0.1 : 0.07),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: AppColors.orange,
                        size: 3.5.w,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        'تأخير ${log.lateMinutes}',
                        style: AppTextStyle.hint.copyWith(
                          color: AppColors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.5.w,
                    vertical: 0.3.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(isDark ? 0.1 : 0.07),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColors.green,
                        size: 3.5.w,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        'في الموعد',
                        style: AppTextStyle.hint.copyWith(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 1.5.h),

          /// Check-in / Check-out / Hours row
          Row(
            children: [
              _buildInfoChip(
                Icons.login_rounded,
                'الدخول',
                log.checkIn,
                AppColors.green,
                isDark,
              ),
              SizedBox(width: 2.w),
              _buildInfoChip(
                Icons.logout_rounded,
                'الخروج',
                log.checkOut,
                AppColors.primary,
                isDark,
              ),
              SizedBox(width: 2.w),
              _buildInfoChip(
                Icons.access_time_filled,
                'ساعات العمل',
                log.workHours,
                AppColors.blue,
                isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(
    IconData icon,
    String label,
    String value,
    Color color,
    bool isDark,
  ) {
    final Color textColor = isDark
        ? AppColors.textMain
        : const Color(0xFF1A1A2E);
    final Color subtextColor = isDark
        ? AppColors.textSub
        : const Color(0xFF6A6A8A);

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        decoration: BoxDecoration(
          color: color.withOpacity(isDark ? 0.06 : 0.04),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 4.w),
            SizedBox(height: 0.4.h),
            Text(
              label,
              style: AppTextStyle.hint.copyWith(color: subtextColor),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 0.2.h),
            Text(
              value,
              style: AppTextStyle.body.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
