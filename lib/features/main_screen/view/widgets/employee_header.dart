import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_cubit/app_cubit.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

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
    final isDark = context.read<AppCubit>().isDark;

    final List<Color> headerGradient = isDark
        ? const [Color(0xFF1e1d2f), Color(0xFF28273d), Color(0xFF1e1d2f)]
        : const [Color(0xFFEAF0FF), Color(0xFFDDE6FF), Color(0xFFEAF0FF)];

    final Color textColor = isDark
        ? AppColors.textMain
        : const Color(0xFF1A1A2E);
    final Color subtextColor = isDark
        ? AppColors.textSub
        : const Color(0xFF5A5A7A);
    final Color iconBgColor = isDark
        ? Colors.white.withOpacity(0.06)
        : Colors.black.withOpacity(0.05);
    final Color iconBorderColor = isDark
        ? Colors.white.withOpacity(0.08)
        : Colors.black.withOpacity(0.06);
    final Color shadowColor = isDark
        ? Colors.black.withOpacity(0.4)
        : Colors.grey.withOpacity(0.2);
    final Color badgeBorderColor = isDark
        ? const Color(0xFF1e1d2f)
        : const Color(0xFFEAF0FF);
    final Color avatarBg = isDark
        ? AppColors.backGround
        : const Color(0xFFF0F0F5);

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
        gradient: LinearGradient(
          colors: headerGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          /// Menu Button
          _buildIconButton(
            icon: Icons.menu_rounded,
            onTap: onMenuTap,
            bgColor: iconBgColor,
            borderColor: iconBorderColor,
            iconColor: textColor,
          ),
          SizedBox(width: 2.w),

          /// Notification Bell
          _buildNotificationButton(
            iconBgColor,
            iconBorderColor,
            textColor,
            badgeBorderColor,
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
                  color: textColor,
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
              backgroundColor: avatarBg,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback? onTap,
    required Color bgColor,
    required Color borderColor,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: iconColor, size: 6.w),
      ),
    );
  }

  Widget _buildNotificationButton(
    Color bgColor,
    Color borderColor,
    Color iconColor,
    Color badgeBorderColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: IconButton(
        onPressed: onNotificationTap ?? () {},
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.notifications_outlined, color: iconColor, size: 6.w),
            Positioned(
              top: -3,
              right: -2,
              child: Container(
                width: 2.5.w,
                height: 2.5.w,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: badgeBorderColor, width: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
