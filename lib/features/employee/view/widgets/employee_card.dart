import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import '../../data/models/employee_model.dart';
import '../../../../my_app.dart';
import '../screens/tracking_screen.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeModel employee;
  final VoidCallback? onTrack;
  final VoidCallback? onAttendance;

  const EmployeeCard({
    super.key,
    required this.employee,
    this.onTrack,
    this.onAttendance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.5.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.backGround2,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// 👤 الجزء القديم زي ما هو
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(
                      MyApp.isDark ? 0.12 : 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_pin_rounded,
                  color: AppColors.primary,
                  size: 6.w,
                ),
              ),
              SizedBox(width: 4.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: AppTextStyle.title.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMain,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      employee.position,
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.textSub,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 4.w,
                color: AppColors.dividerColor,
              ),
            ],
          ),

          /// 🔻 مسافة
          SizedBox(height: 2.h),

          /// 🔘 الزرارين
          Row(
            children: [
              /// تتبع
              Expanded(
                child: GestureDetector(
                  onTap: onTrack,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.2.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "تتبع",
                        style: AppTextStyle.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 3.w),

              /// تحضير
              Expanded(
                child: GestureDetector(
                  onTap: onAttendance,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.2.h),
                    decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "تحضير",
                        style: AppTextStyle.body.copyWith(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}