import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

import '../../../componnents/icon_button.dart';

class EmployeeHeader extends StatelessWidget {
  final String name;
  final String jobTitle;
  final String profileImageUrl;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMenuTap;

  const EmployeeHeader({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.profileImageUrl,
    this.onNotificationTap,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 1.5.h,
        left: 5.w,
        right: 5.w,
        bottom: 2.5.h,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          /// Menu Button
          AppIcon(
            icon: Icon(
              Icons.menu_rounded,
              color: AppColors.textMain,
              size: 6.w,
            ),
            onTap: onMenuTap,
          ),

          SizedBox(width: 2.w),
          AppIcon(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textMain,
                  size: 6.w,
                ),
                Positioned(
                  top: -3,
                  right: -2,
                  child: Container(
                    width: 2.5.w,
                    height: 2.5.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.badgeBorderColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            onTap: onNotificationTap ?? () {},
          ),

          const Spacer(),

          /// Name & Job Title
          Column(
            crossAxisAlignment: context.locale.languageCode == 'ar'
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: AppTextStyle.title.copyWith(
                  color: AppColors.textMain,
                  fontWeight: FontWeight.w700,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 0.4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  jobTitle,
                  style: AppTextStyle.smallBody.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          AppSizedBox.w3,

          /// Profile Avatar
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.8),
                  AppColors.primary.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 14,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 6.5.w,
              backgroundColor: AppColors.avatarBg,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
          ),
        ],
      ),
    );
  }
}
