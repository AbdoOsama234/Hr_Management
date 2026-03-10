import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_cubit/app_cubit.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/features/main_screen/controller/main_screen_cubit.dart';
import 'package:hr_manegement/features/main_screen/view/widgets/drawer_menu_item.dart';
import 'package:hr_manegement/features/main_screen/view/widgets/drawer_profile_header.dart';
import 'package:hr_manegement/features/profile/view/screens/profile_screen.dart';
import 'package:hr_manegement/features/holiday__requests/view/screens/holiday_screen.dart';
import 'package:hr_manegement/features/permission_request/view/screens/permission_screen.dart';
import 'package:hr_manegement/features/loan__requests/view/screens/loan_screen.dart';
import 'package:hr_manegement/features/business_trip_requests/view/screens/business_trip_screen.dart';
import 'package:hr_manegement/features/mission_requests/view/screens/mission_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    final isDark = appCubit.isDark;

    final isArabic = context.locale.languageCode == 'ar';

    final state = context.watch<MainScreenCubit>().state;

    String name = "Employee Name";
    String jobTitle = "Job Title";
    String profileImage = "https://ui-avatars.com/api/?name=User";

    if (state is MainScreenLoaded) {
      name = state.dashboard.employeeName;
      jobTitle = state.dashboard.jobTitle;
      profileImage = state.dashboard.avatar;
    }

    return Drawer(
      backgroundColor: isDark ? AppColors.backGround : Colors.white,
      width: 80.w,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          /// Profile Header
          DrawerProfileHeader(
            name: name,
            jobTitle: jobTitle,
            profileImageUrl: profileImage,
            isDark: isDark,
            onTap: () {
              _navigateTo(context, const ProfileScreen());
            },
          ),

          /// Menu Items
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                children: [
                  DrawerMenuItem(
                    icon: Icons.event_note_rounded,
                    title: 'holiday_request'.tr(),
                    isDark: isDark,
                    onTap: () => _navigateTo(context, const HolidayScreen()),
                  ),
                  _buildDivider(isDark),

                  DrawerMenuItem(
                    icon: Icons.access_time_rounded,
                    title: 'permission_request'.tr(),
                    isDark: isDark,
                    onTap: () => _navigateTo(context, const PermissionScreen()),
                  ),
                  _buildDivider(isDark),

                  DrawerMenuItem(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'loan_request'.tr(),
                    isDark: isDark,
                    onTap: () => _navigateTo(context, const LoanScreen()),
                  ),
                  _buildDivider(isDark),

                  DrawerMenuItem(
                    icon: Icons.flight_takeoff_rounded,
                    title: 'business_trip_request'.tr(),
                    isDark: isDark,
                    onTap: () =>
                        _navigateTo(context, const BusinessTripScreen()),
                  ),
                  _buildDivider(isDark),

                  DrawerMenuItem(
                    icon: Icons.work_outline_rounded,
                    title: 'mission_request'.tr(),
                    isDark: isDark,
                    onTap: () => _navigateTo(context, const MissionScreen()),
                  ),
                  _buildDivider(isDark),

                  /// Dark Mode Toggle
                  DrawerMenuItem(
                    icon: Icons.dark_mode_rounded,
                    title: 'change_theme'.tr(),
                    isDark: isDark,
                    trailingIcon: isDark
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    onTap: () {
                      context.read<AppCubit>().changeTheme();
                    },
                  ),

                  _buildDivider(isDark),

                  /// Language Toggle
                  DrawerMenuItem(
                    icon: Icons.language_rounded,
                    title: 'change_language'.tr(),
                    isDark: isDark,
                    trailingIcon: null,
                    onTap: () {
                      if (context.locale.languageCode == 'ar') {
                        context.setLocale(const Locale('en'));
                      } else {
                        context.setLocale(const Locale('ar'));
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 0.5.h,
                    ),
                    child: Row(
                      mainAxisAlignment: isArabic
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Text(
                          isArabic ? 'العربية' : 'English',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Version
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Text(
              '${'version'.tr()} 1.0.0',
              style: TextStyle(
                color: isDark ? Colors.white24 : Colors.black26,
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      color: isDark
          ? Colors.white.withOpacity(0.05)
          : Colors.black.withOpacity(0.05),
      indent: 14.w,
      endIndent: 2.w,
    );
  }
}
