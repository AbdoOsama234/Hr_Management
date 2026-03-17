import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

class ProfileInfoSection extends StatelessWidget {
  final String name;
  final String phone;
  final String jobTitle;

  const ProfileInfoSection({
    super.key,
    required this.name,
    required this.phone,
    required this.jobTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backGround2,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section title
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.primary,
                    size: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'personal_info'.tr(),
                    style: AppTextStyle.title.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMain,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            _buildInfoRow(
              icon: Icons.person_outline_rounded,
              label: 'full_name'.tr(),
              value: name,
              showDivider: true,
            ),
            _buildInfoRow(
              icon: Icons.phone_outlined,
              label: 'phone_number'.tr(),
              value: phone,
              showDivider: true,
            ),
            _buildInfoRow(
              icon: Icons.work_outline_rounded,
              label: 'job_title'.tr(),
              value: jobTitle,
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 1.8.h,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.5.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 5.w,
                ),
              ),
              AppSizedBox.w4,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyle.smallBody.copyWith(
                        color: AppColors.textSub,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(height: 0.3.h),
                    Text(
                      value,
                      style: AppTextStyle.title.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: AppColors.textMain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.dividerColor,
            indent: 18.w,
          ),
      ],
    );
  }
}
