import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:hr_manegement/my_app.dart';

class LateHoursCard extends StatelessWidget {
  final double lateHoursUsed;
  final double lateHoursAllowed;

  const LateHoursCard({
    super.key,
    required this.lateHoursUsed,
    required this.lateHoursAllowed,
  });

  double get _remaining => lateHoursAllowed - lateHoursUsed;
  double get _progress => _remaining / lateHoursAllowed;

  Color get _statusColor {
    if (_progress <= 0.2) return AppColors.primary; // Red if less than 20% left
    if (_progress <= 0.5)
      return AppColors.orange; // Orange if less than 50% left
    return AppColors.mintGreen; // Green if more than 50% left
  }

  @override
  Widget build(BuildContext context) {
    final Color trackBg = MyApp.isDark
        ? AppColors.darkGrey.withOpacity(0.15)
        : Colors.grey.withOpacity(0.12);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.h),
      decoration: BoxDecoration(
        color: AppColors.backGround2,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
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
                  color: _statusColor.withOpacity(MyApp.isDark ? 0.12 : 0.08),
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
                'late_hours'.tr(),
                style: AppTextStyle.title.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.5.w,
                  vertical: 0.6.h,
                ),
                decoration: BoxDecoration(
                  color: _statusColor.withOpacity(MyApp.isDark ? 0.12 : 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _statusColor.withOpacity(0.2)),
                ),
                child: Text(
                  '${'used'.tr()} ${lateHoursUsed.toInt()} ${'hours'.tr()}',
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
                        backgroundColor: AppColors.backGround2,
                        valueColor: AlwaysStoppedAnimation<Color>(_statusColor),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${_remaining.toInt()}h',
                          style: AppTextStyle.subHeadline.copyWith(
                            color: AppColors.textMain,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'remaining'.tr(),
                          style: AppTextStyle.hint.copyWith(),
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
                      'the_remaining'.tr(),
                      '${_remaining.toInt()} ${'hours'.tr()}',
                      AppColors.primary,
                      // _statusColor,
                    ),
                    SizedBox(height: 1.2.h),
                    _buildDetailRow(
                      'the_used'.tr(),
                      '${lateHoursUsed.toInt()} ${'hour'.tr()}',
                      AppColors.primary,
                    ),
                    SizedBox(height: 1.2.h),
                    _buildDetailRow(
                      'the_allowed'.tr(),
                      '${lateHoursAllowed.toInt()} ${'hours'.tr()}',
                      AppColors.primary,
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
                '${_remaining.toInt()}h ${'remaining'.tr()} / ${lateHoursAllowed.toInt()}h ${'late_limit'.tr()}',
                style: AppTextStyle.smallBody.copyWith(
                  color: AppColors.textSub,
                ),
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
    // Color textColor,
    // Color subtextColor,
    // double bgOpacity,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: dotColor.withOpacity(0.5),
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
          Text(label, style: AppTextStyle.smallBody),
          const Spacer(),
          Text(
            value,
            style: AppTextStyle.body.copyWith(
              color: AppColors.textMain,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
