import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_cubit/app_cubit.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

class LateHoursCard extends StatelessWidget {
  final double lateHoursUsed;
  final double lateHoursAllowed;

  const LateHoursCard({
    super.key,
    required this.lateHoursUsed,
    required this.lateHoursAllowed,
  });

  double get _remaining => lateHoursAllowed - lateHoursUsed;
  double get _progress => lateHoursUsed / lateHoursAllowed;

  Color get _statusColor {
    if (_progress >= 0.85) return AppColors.primary;
    if (_progress >= 0.5) return AppColors.orange;
    return AppColors.green;
  }

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
    final Color trackBg = isDark
        ? AppColors.darkGrey.withOpacity(0.15)
        : Colors.grey.withOpacity(0.12);
    final double detailRowBgOpacity = isDark ? 0.06 : 0.05;

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
          /// Header Row
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: _statusColor.withOpacity(isDark ? 0.12 : 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.timer_outlined,
                  color: _statusColor,
                  size: 5.w,
                ),
              ),
              SizedBox(width: 2.5.w),
              Text(
                'التأخير',
                style: AppTextStyle.title.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.5.w,
                  vertical: 0.6.h,
                ),
                decoration: BoxDecoration(
                  color: _statusColor.withOpacity(isDark ? 0.12 : 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _statusColor.withOpacity(0.2)),
                ),
                child: Text(
                  'متبقي ${_remaining.toInt()} ساعات',
                  style: AppTextStyle.smallBody.copyWith(
                    color: _statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.5.h),

          /// Circular indicator + detail rows
          Row(
            children: [
              /// Circular Progress
              SizedBox(
                width: 24.w,
                height: 24.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: CircularProgressIndicator(
                        value: _progress,
                        strokeWidth: 7,
                        backgroundColor: trackBg,
                        valueColor: AlwaysStoppedAnimation<Color>(_statusColor),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${lateHoursUsed.toInt()}h',
                          style: AppTextStyle.subHeadline.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'مستخدم',
                          style: AppTextStyle.hint.copyWith(
                            color: subtextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5.w),

              /// Detail rows
              Expanded(
                child: Column(
                  children: [
                    _buildDetailRow(
                      'المستخدم',
                      '${lateHoursUsed.toInt()} ساعة',
                      _statusColor,
                      textColor,
                      subtextColor,
                      detailRowBgOpacity,
                    ),
                    SizedBox(height: 1.2.h),
                    _buildDetailRow(
                      'المسموح',
                      '${lateHoursAllowed.toInt()} ساعات',
                      AppColors.blue,
                      textColor,
                      subtextColor,
                      detailRowBgOpacity,
                    ),
                    SizedBox(height: 1.2.h),
                    _buildDetailRow(
                      'المتبقي',
                      '${_remaining.toInt()} ساعات',
                      AppColors.green,
                      textColor,
                      subtextColor,
                      detailRowBgOpacity,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.5.h),

          /// Linear Progress Bar section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${lateHoursUsed.toInt()}h مستخدم / ${lateHoursAllowed.toInt()}h مسموح',
                style: AppTextStyle.smallBody.copyWith(color: subtextColor),
              ),
              Text(
                '${(_progress * 100).toInt()}%',
                style: AppTextStyle.body.copyWith(
                  color: _statusColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 0.8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 1.h,
              backgroundColor: trackBg,
              valueColor: AlwaysStoppedAnimation<Color>(_statusColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    Color dotColor,
    Color textColor,
    Color subtextColor,
    double bgOpacity,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: dotColor.withOpacity(bgOpacity),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 2.w,
            height: 2.w,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          SizedBox(width: 2.w),
          Text(
            label,
            style: AppTextStyle.smallBody.copyWith(color: subtextColor),
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyle.body.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
