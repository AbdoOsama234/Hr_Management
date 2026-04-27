import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

import '../../../main_screen/controller/main_screen_cubit.dart';
import '../../controller/profile_cubit.dart';
import '../../controller/profile_state.dart';
import '../widgets/profile_edit_form.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    /// Feed dashboard data into the shared ProfileCubit (only once)
    final profileCubit = context.read<ProfileCubit>();
    if (profileCubit.state is! ProfileLoaded) {
      final mainState = context.read<MainScreenCubit>().state;
      if (mainState is MainScreenLoaded) {
        profileCubit.loadProfile(mainState);
      } else {
        profileCubit.loadProfile();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          /// 🔄 Loading
          if (state is ProfileInitial || state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          /// ❌ Error
          if (state is ProfileError) {
            return const Center(child: Text("Something went wrong"));
          }

          /// ✅ Loaded
          if (state is ProfileLoaded) {
            return _buildContent(
              context: context,
              name: state.name,
              phone: state.phone,
              jobTitle: state.jobTitle,
              imagePath: state.imagePath,
              isEditMode: state.isEditMode,
              showSuccessSnack: state.isUpdated,
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
    required String name,
    required String phone,
    required String jobTitle,
    String? imagePath,
    required bool isEditMode,
    bool showSuccessSnack = false,
  }) {
    /// ✅ SnackBar
    if (showSuccessSnack) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 2.w),
                Text(
                  'profile_updated_successfully'.tr(),
                  style: AppTextStyle.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.mintGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            duration: const Duration(seconds: 2),
          ),
        );
      });
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          /// 🔥 HEADER
          Stack(
            children: [
              ProfileHeader(
                name: name,
                jobTitle: jobTitle,
                imagePath: imagePath,
              ),

              /// 🔙 Back
              PositionedDirectional(
                top: MediaQuery.of(context).padding.top + 1.h,
                start: 4.w,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.white,
                      size: 5.w,
                    ),
                  ),
                ),
              ),

              /// ✏️ Edit
              if (!isEditMode)
                PositionedDirectional(
                  top: MediaQuery.of(context).padding.top + 1.h,
                  end: 4.w,
                  child: GestureDetector(
                    onTap: () => context.read<ProfileCubit>().toggleEditMode(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit_rounded,
                            color: AppColors.white,
                            size: 4.w,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            'edit'.tr(),
                            style: AppTextStyle.body.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),

          /// ✨ Animation
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: isEditMode
                ? ProfileEditForm(
                    key: const ValueKey('edit'),
                    name: name,
                    phone: phone,
                    jobTitle: jobTitle,
                  )
                : ProfileInfoSection(
                    key: const ValueKey('info'),
                    name: name,
                    phone: phone,
                    jobTitle: jobTitle,
                  ),
          ),

          AppSizedBox.h5,
        ],
      ),
    );
  }
}
