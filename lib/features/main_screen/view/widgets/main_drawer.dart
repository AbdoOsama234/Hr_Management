import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_cubit/app_cubit.dart';
import 'package:hr_manegement/core/app_cubit/app_state.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/features/auth/view/screens/login_screen.dart';
import 'package:hr_manegement/features/componnents/custom_button.dart';
import 'package:hr_manegement/features/main_screen/controller/main_screen_cubit.dart';
import 'package:hr_manegement/features/main_screen/view/widgets/drawer_menu_item.dart';
import 'package:hr_manegement/features/main_screen/view/widgets/drawer_profile_header.dart';
import 'package:hr_manegement/features/profile/view/screens/profile_screen.dart';
import 'package:hr_manegement/features/holiday__requests/view/screens/holiday_screen.dart';
import 'package:hr_manegement/features/permission_request/view/screens/permission_screen.dart';
import 'package:hr_manegement/features/loan__requests/view/screens/loan_screen.dart';
import 'package:hr_manegement/features/business_trip_requests/view/screens/business_trip_screen.dart';
import 'package:hr_manegement/features/errand_requests/view/screens/errand_screen.dart';
import 'package:hr_manegement/my_app.dart';

import '../../../ideas/view/screens/ideas_screen.dart';
import '../../../my_mission/view/screens/my_mission_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    // final isDark = appCubit.isDark;

    // final isArabic = context.locale.languageCode == 'ar';

    final state = context.watch<MainScreenCubit>().state;

    String name = "Employee Name";
    String jobTitle = "Job Title";
    String profileImage = "https://ui-avatars.com/api/?name=User";

    if (state is MainScreenLoaded) {
      name = state.dashboard.employeeName;
      jobTitle = state.dashboard.jobTitle;
      profileImage = state.dashboard.avatar;
    }

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: AppColors.backGround,
          width: 80.w,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(30),
              bottomEnd: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              /// Profile Header
              DrawerProfileHeader(
                name: name,
                jobTitle: jobTitle,
                profileImageUrl: profileImage,

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
                        icon: Icons.task_alt_rounded,
                        title: 'my_missions'.tr(),

                        onTap: () =>
                            _navigateTo(context, const MyMissionScreen()),
                      ),
                      _buildDivider(),
                      DrawerMenuItem(
                        icon: Icons.lightbulb_outline_rounded,
                        title: 'ideas'.tr(),
                        onTap: () => _navigateTo(context, const IdeasScreen()),
                      ),
                      _buildDivider(),
                      DrawerMenuItem(
                        icon: Icons.event_note_rounded,
                        title: 'holiday_request'.tr(),

                        onTap: () =>
                            _navigateTo(context, const HolidayScreen()),
                      ),
                      _buildDivider(),

                      DrawerMenuItem(
                        icon: Icons.access_time_rounded,
                        title: 'permission_request'.tr(),

                        onTap: () =>
                            _navigateTo(context, const PermissionScreen()),
                      ),
                      _buildDivider(),

                      DrawerMenuItem(
                        icon: Icons.account_balance_wallet_outlined,
                        title: 'loan_request'.tr(),

                        onTap: () => _navigateTo(context, const LoanScreen()),
                      ),
                      _buildDivider(),

                      DrawerMenuItem(
                        icon: Icons.flight_takeoff_rounded,
                        title: 'business_trip_request'.tr(),

                        onTap: () =>
                            _navigateTo(context, const BusinessTripScreen()),
                      ),
                      _buildDivider(),

                      DrawerMenuItem(
                        icon: Icons.work_outline_rounded,
                        title: 'errand_request'.tr(),
                        onTap: () => _navigateTo(context, const ErrandScreen()),
                      ),
                      _buildDivider(),

                      /// Dark Mode Toggle
                      DrawerMenuItem(
                        icon: Icons.dark_mode_rounded,
                        title: 'change_theme'.tr(),

                        trailingIcon: MyApp.isDark
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                        onTap: () {
                          appCubit.changeTheme();
                        },
                      ),

                      _buildDivider(),

                      /// Language Toggle
                      DrawerMenuItem(
                        icon: Icons.language_rounded,
                        title: 'change_language'.tr(),

                        trailingIcon: null,
                        onTap: () {
                          appCubit.changeLang(
                            appCubit.locale.languageCode == 'ar' ? 'en' : 'ar',
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 0.5.h,
                        ),
                        child: Row(
                          mainAxisAlignment:
                              appCubit.locale.languageCode == "ar"
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Text(
                              appCubit.locale.languageCode == "ar"
                                  ? 'العربية'
                                  : 'English',
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: CustomButton(
                  text: 'logout'.tr(),
                  width: 300,
                  fontsize: 12,
                  height: 50,
                  butcolor: MyApp.isDark
                      ? AppColors.primary
                      : AppColors.primary,
                  radius: 12,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ),

              /// Version
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  '${'version'.tr()} 1.0.0',
                  style: TextStyle(
                    color: MyApp.isDark ? Colors.white24 : Colors.black26,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Widget _buildDivider() {
    return Divider(
      color: MyApp.isDark
          ? Colors.white.withOpacity(0.05)
          : Colors.black.withOpacity(0.05),
      indent: 14.w,
      endIndent: 2.w,
    );
  }
}
