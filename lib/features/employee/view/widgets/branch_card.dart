import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_router.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:hr_manegement/features/employee/data/models/branches_model.dart';

class BranchCard extends StatelessWidget {
  final BrancheModel branche;

  const BranchCard({super.key, required this.branche});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.branchEmployees,
          arguments: branche,
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Branch Name
            Text(
              branche.localName,
              textAlign: TextAlign.center,
              style: AppTextStyle.title.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 1.h),

            /// Subtitle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "view_employees".tr(),
                  style: AppTextStyle.smallBody.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 1.w),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 3.w,
                  color: AppColors.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
