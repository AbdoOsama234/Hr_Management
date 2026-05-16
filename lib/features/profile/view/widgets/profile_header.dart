import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:hr_manegement/my_app.dart';

import '../../../../core/di/di.dart';
import '../../../../data/storage/local/app_prefs.dart';
import '../../controller/profile_cubit.dart';

class ProfileHeader extends StatefulWidget {
  final String name;
  final String jobTitle;
  final String? imagePath;
  final String? avatarUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.jobTitle,
    this.imagePath,
    this.avatarUrl,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _avatarController;
  late Animation<double> _avatarScale;

  @override
  void initState() {
    super.initState();
    _avatarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _avatarScale = CurvedAnimation(
      parent: _avatarController,
      curve: Curves.elasticOut,
    );
    _avatarController.forward();
  }

  @override
  void dispose() {
    _avatarController.dispose();
    super.dispose();
  }

  ImageProvider? _getAvatarImage() {
    if (widget.imagePath != null && widget.imagePath!.isNotEmpty) {
      final file = File(widget.imagePath!);
      if (file.existsSync()) return FileImage(file);
    }
    if (widget.avatarUrl != null && widget.avatarUrl!.isNotEmpty) {
      return NetworkImage(widget.avatarUrl!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MyApp.isDark;
    final avatarImage = _getAvatarImage();

    return SizedBox(
      height: 38.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Gradient background — soft & minimal
          Container(
            height: 26.h,

            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        AppColors.primary.withValues(alpha: 0.25),
                        AppColors.backGroundDark,
                      ]
                    : [
                        AppColors.primary.withValues(alpha: 0.12),
                        AppColors.backGroundLight,
                      ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Text(
                  'profile'.tr(),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.headline.copyWith(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),

          // Profile avatar — overlapping header
          Positioned(
            bottom: 2.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => context.read<ProfileCubit>().updateImage(),
                  child: ScaleTransition(
                    scale: _avatarScale,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              width: 2.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(
                                  alpha: 0.15,
                                ),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 14.w,
                            backgroundColor: AppColors.backGround2,
                            backgroundImage: avatarImage,
                            child: avatarImage == null
                                ? Icon(
                                    Icons.person_rounded,
                                    size: 14.w,
                                    color: AppColors.textSub.withValues(
                                      alpha: 0.4,
                                    ),
                                  )
                                : null,
                          ),
                        ),

                        /// 📸 Camera
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.backGround2,
                                width: 3,
                              ),
                            ),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: AppColors.white,
                              size: 4.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 1.8.h),

                /// 🟢 الاسم
                Text(
                  getIt<AppPreferences>().loadUserData?.name ?? "",
                  style: AppTextStyle.title.copyWith(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 0.6.h),

                /// 🔥 الوظيفة تحت الاسم مباشرة (تحسين الشكل)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: 0.4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.jobTitle,
                    style: AppTextStyle.body.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
