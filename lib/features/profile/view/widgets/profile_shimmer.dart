import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          // Header shimmer
          Container(
            height: 28.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
          ),

          // Avatar shimmer
          Transform.translate(
            offset: Offset(0, -6.h),
            child: Column(
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.borderColor,
                  highlightColor: AppColors.backGround2,
                  child: CircleAvatar(
                    radius: 14.w,
                    backgroundColor: AppColors.borderColor,
                  ),
                ),
                SizedBox(height: 1.5.h),

                // Name shimmer
                Shimmer.fromColors(
                  baseColor: AppColors.borderColor,
                  highlightColor: AppColors.backGround2,
                  child: Container(
                    height: 2.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 1.h),

                // Job title shimmer
                Shimmer.fromColors(
                  baseColor: AppColors.borderColor,
                  highlightColor: AppColors.backGround2,
                  child: Container(
                    height: 1.5.h,
                    width: 25.w,
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Info card shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Shimmer.fromColors(
              baseColor: AppColors.borderColor,
              highlightColor: AppColors.backGround2,
              child: Container(
                height: 22.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
