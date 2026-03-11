import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

class DrawerProfileHeader extends StatelessWidget {
  final String name;
  final String jobTitle;
  final String profileImageUrl;
  final VoidCallback onTap;

  const DrawerProfileHeader({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.profileImageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final List<Color> headerGradient = isDark
    //     ? const [Color(0xFF1e1d2f), Color(0xFF28273d)]
    //     : const [Color(0xFFEAF0FF), Color(0xFFDDE6FF)];

    // final Color textColor = isDark
    //     ? AppColors.textMain
    //     : const Color(0xFF1A1A2E);
    // final Color avatarBg = isDark
    //     ? AppColors.backGround
    //     : const Color(0xFFF0F0F5);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          4.w,
          MediaQuery.of(context).padding.top + 2.h,
          4.w,
          3.h,
        ),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.4),
                  ],
                ),
              ),
              child: CircleAvatar(
                radius: 7.w,
                backgroundColor: AppColors.backGround,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: AppTextStyle.title.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.6.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.5.w,
                      vertical: 0.3.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      jobTitle,
                      style: AppTextStyle.smallBody.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primary.withOpacity(0.5),
              size: 4.w,
            ),
          ],
        ),
      ),
    );
  }
}
