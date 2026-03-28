import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../../../my_app.dart';
import '../../../my_mission/data/models/mission_model.dart';

class DailyTasksWidget extends StatelessWidget {
  final MyMissionModel mission;

  const DailyTasksWidget({super.key, required this.mission});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.2.h),
      decoration: BoxDecoration(
        color: AppColors.backGround2,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(0.6),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Top Row (Date + Status)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 3.8.w,
                    color: AppColors.primary.withOpacity(0.7),
                  ),
                  SizedBox(width: 1.8.w),
                  Text(
                    dateFoemated(mission.date.toString()),
                    style: AppTextStyle.smallBody.copyWith(
                      color: AppColors.textSub,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              _buildStatusChip(mission.status),
            ],
          ),

          AppSizedBox.h1,

          /// 🔹 Title
          Text(
            mission.notes,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.title.copyWith(
              color: AppColors.textSub,
              fontWeight: FontWeight.w400,
              height: 1.3, // improves readability
            ),
          ),

          AppSizedBox.h1,

          /// 🔹 Importance
          _buildImportanceChip(mission.importance),
        ],
      ),
    );
  }

  Widget _buildStatusChip(MissionStatus status) {
    late Color color;
    late String label;

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
      padding: EdgeInsets.symmetric(horizontal: 2.8.w, vertical: 0.6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(MyApp.isDark ? 0.18 : 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppTextStyle.smallBody.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp,
        ),
      ),
    );
  }

  Widget _buildImportanceChip(MissionImportance importance) {
    late Color color;
    late String label;

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
      padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Text(
        label,
        style: AppTextStyle.smallBody.copyWith(
          color: color,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}