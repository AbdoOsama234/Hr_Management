import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_cubit/app_cubit.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

class TodayStatusCard extends StatelessWidget {
  final String checkIn;
  final String checkOut;
  final String workedHours;

  const TodayStatusCard({
    super.key,
    required this.checkIn,
    required this.checkOut,
    required this.workedHours,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.select((AppCubit cubit) => cubit.isDark);
    final Color cardBg =
    isDark ? AppColors.backGround2 : const Color(0xFFFFFFFF);

    final Color borderColor = isDark
        ? Colors.white.withOpacity(.05)
        : Colors.grey.withOpacity(.12);

    final Color shadowColor = isDark
        ? Colors.black.withOpacity(.3)
        : Colors.grey.withOpacity(.15);

    final Color textColor =
    isDark ? AppColors.textMain : const Color(0xFF1A1A2E);

    final Color subtextColor =
    isDark ? AppColors.textSub : const Color(0xFF6A6A8A);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 2.5.h,
      ),
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

          /// Title
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(
                    isDark ? .12 : .08,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.today_rounded,
                  color: AppColors.primary,
                  size: 5.w,
                ),
              ),

              SizedBox(width: 2.5.w),

              Text(
                "حالة اليوم",
                style: AppTextStyle.title.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: 2.5.h),

          /// Status Row
          Row(
            children: [
              _buildItem(
                icon: Icons.login_rounded,
                label: "الدخول",
                value: checkIn,
                color: AppColors.green,
                textColor: textColor,
                subtextColor: subtextColor,
                isDark: isDark,
              ),

              SizedBox(width: 2.w),

              _buildItem(
                icon: Icons.logout_rounded,
                label: "الخروج",
                value: checkOut,
                color: AppColors.primary,
                textColor: textColor,
                subtextColor: subtextColor,
                isDark: isDark,
              ),

              SizedBox(width: 2.w),

              _buildItem(
                icon: Icons.access_time_filled,
                label: "ساعات العمل",
                value: workedHours,
                color: AppColors.blue,
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

  Widget _buildItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color textColor,
    required Color subtextColor,
    required bool isDark,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 1.2.h,
          horizontal: 2.w,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(isDark ? .06 : .04),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [

            Icon(
              icon,
              color: color,
              size: 5.w,
            ),

            SizedBox(height: .5.h),

            Text(
              label,
              style: AppTextStyle.smallBody.copyWith(
                color: subtextColor,
              ),
            ),

            SizedBox(height: .3.h),

            Text(
              value,
              style: AppTextStyle.body.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}