// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_cubit/app_cubit.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/features/auth/view/screens/login_screen.dart';
import 'package:hr_manegement/features/main_screen/view/widgets/drawer_menu_item.dart';
import 'package:hr_manegement/features/main_screen/view/widgets/drawer_profile_header.dart';
import 'package:hr_manegement/features/profile/view/screens/profile_screen.dart';
import 'package:hr_manegement/features/holiday__requests/view/screens/holiday_screen.dart';
import 'package:hr_manegement/features/permission_request/view/screens/permission_screen.dart';
import 'package:hr_manegement/features/loan__requests/view/screens/loan_screen.dart';
import 'package:hr_manegement/features/business_trip_requests/view/screens/business_trip_screen.dart';
import 'package:hr_manegement/features/errand_requests/view/screens/errand_screen.dart';
import 'package:hr_manegement/my_app.dart';

import '../../../../ sheard/componnents/custom_button.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/di/di.dart' show getIt;
import '../../../../core/helpers/background_tracking_services.dart';
import '../../../../data/storage/local/app_prefs.dart' show AppPreferences;
import '../../../employee/view/screens/branches_screen.dart';
import '../../../employees_requests/view/screens/employees_requests_screen.dart';
import '../../../my_mission/view/screens/my_mission_screen.dart';
import '../../../profile/controller/profile_cubit.dart';
import '../../../profile/controller/profile_state.dart';
import 'drawer_section.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String jobTitle = '';
        ImageProvider? imageProvider;

        if (state is ProfileLoaded) {
          jobTitle = state.jobTitle;

          if (state.imagePath != null && state.imagePath!.isNotEmpty) {
            imageProvider = FileImage(File(state.imagePath!));
          } else if (state.avatarUrl != null && state.avatarUrl!.isNotEmpty) {
            imageProvider = NetworkImage(state.avatarUrl!);
          } else {
            imageProvider = const AssetImage(AppAssets.avatar2);
          }
        }

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
              /// Profile
              DrawerProfileHeader(
                name: getIt<AppPreferences>().loadUserData?.name ?? "",
                jobTitle: jobTitle,
                profileImageProvider: imageProvider,
                onTap: () {
                  _navigateTo(context, const ProfileScreen());
                },
              ),

              /// Menu
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Column(
                    children: [
                      /// 🔹 General
                      DrawerSection(
                        title: "general".tr(),
                        icon: Icons.dashboard_rounded,
                        children: [
                          DrawerMenuItem(
                            icon: Icons.people_alt_rounded,
                            title: 'employees'.tr(),
                            onTap: () =>
                                _navigateTo(context, const BranchesScreen()),
                          ),
                          DrawerMenuItem(
                            icon: Icons.task_alt_rounded,
                            title: 'employees_requests'.tr(),
                            onTap: () => _navigateTo(
                              context,
                              const EmployeesRequestsScreen(),
                            ),
                          ),
                          DrawerMenuItem(
                            icon: Icons.task_alt_rounded,
                            title: 'my_missions'.tr(),
                            onTap: () =>
                                _navigateTo(context, const MyMissionScreen()),
                          ),
                        ],
                      ),

                      /// 🔹 Requests
                      DrawerSection(
                        title: "requests".tr(),
                        icon: Icons.request_page_rounded,
                        children: [
                          DrawerMenuItem(
                            icon: Icons.event_note_rounded,
                            title: 'holiday_request'.tr(),
                            onTap: () =>
                                _navigateTo(context, const HolidayScreen()),
                          ),
                          DrawerMenuItem(
                            icon: Icons.access_time_rounded,
                            title: 'permission_request'.tr(),
                            onTap: () =>
                                _navigateTo(context, const PermissionScreen()),
                          ),
                          DrawerMenuItem(
                            icon: Icons.account_balance_wallet_outlined,
                            title: 'loan_request'.tr(),
                            onTap: () =>
                                _navigateTo(context, const LoanScreen()),
                          ),
                          DrawerMenuItem(
                            icon: Icons.flight_takeoff_rounded,
                            title: 'business_trip_request'.tr(),
                            onTap: () => _navigateTo(
                              context,
                              const BusinessTripScreen(),
                            ),
                          ),
                          DrawerMenuItem(
                            icon: Icons.work_outline_rounded,
                            title: 'errand_request'.tr(),
                            onTap: () =>
                                _navigateTo(context, const ErrandScreen()),
                          ),
                          // DrawerMenuItem(
                          //   icon: Icons.lightbulb_outline_rounded,
                          //   title: 'ideas'.tr(),
                          //   onTap: () =>
                          //       _navigateTo(context, const IdeasScreen()),
                          // ),
                        ],
                      ),

                      /// 🔹 Settings
                      DrawerSection(
                        title: "settings".tr(),
                        icon: Icons.settings_rounded,
                        children: [
                          DrawerMenuItem(
                            icon: Icons.dark_mode_rounded,
                            title: 'change_theme'.tr(),
                            trailingIcon: MyApp.isDark
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                            onTap: appCubit.changeTheme,
                          ),
                          DrawerMenuItem(
                            icon: Icons.language_rounded,
                            title: 'change_language'.tr(),
                            onTap: () {
                              appCubit.changeLang(
                                appCubit.locale.languageCode == 'ar'
                                    ? 'en'
                                    : 'ar',
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// Logout
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: CustomButton(
                  text: 'logout'.tr(),
                  width: 300,
                  fontsize: 12,
                  height: 50,
                  radius: 12,
                  onTap: () async {
                    await getIt<AppPreferences>().logOut();
                    await BackgroundTrackingManager.stop();
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
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
}
