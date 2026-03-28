import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../data/models/mission_model.dart';
import '../../../../my_app.dart';

class MyMissionItemCard extends StatelessWidget {
  final MyMissionModel mission;

  const MyMissionItemCard({super.key, required this.mission});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 4.w,
                    color: AppColors.primary.withOpacity(0.6),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    dateFoemated(mission.date.toString()),
                    style: AppTextStyle.hint.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildStatusChip(mission.status),
            ],
          ),
          AppSizedBox.h2,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mission.notes,
                      style: AppTextStyle.title.copyWith(
                        color: AppColors.textMain,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppSizedBox.h1,
                    _buildImportanceChip(mission.importance),
                  ],
                ),
              ),
              // No edit or delete buttons here
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(MissionStatus status) {
    Color color;
    String label;

    switch (status) {
      case MissionStatus.pending:
        color = AppColors.orange;
        label = 'status_pending'.tr();
        break;
      case MissionStatus.approved:
        color = AppColors.green;
        label = 'status_approved'.tr();
        break;
      case MissionStatus.rejected:
        color = AppColors.red;
        label = 'status_rejected'.tr();
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(MyApp.isDark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: AppTextStyle.smallBody.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildImportanceChip(MissionImportance importance) {
    Color color;
    String label;

    switch (importance) {
      case MissionImportance.low:
        color = Colors.blue;
        label = 'importance_low'.tr();
        break;
      case MissionImportance.medium:
        color = Colors.orange;
        label = 'importance_medium'.tr();
        break;
      case MissionImportance.high:
        color = Colors.red;
        label = 'importance_high'.tr();
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: AppTextStyle.hint.copyWith(
          color: color,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
