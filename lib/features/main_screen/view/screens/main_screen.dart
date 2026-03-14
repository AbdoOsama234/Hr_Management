import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_cubit/app_cubit.dart';
import 'package:hr_manegement/core/app_cubit/app_state.dart';

import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

import '../../controller/main_screen_cubit.dart';
import '../widgets/employee_header.dart';
import '../widgets/today_status_card.dart';
import '../widgets/attendance_summary_card.dart';
import '../widgets/late_hours_card.dart';
import '../widgets/weekly_report_list.dart';
import '../widgets/main_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MainScreenCubit>()..loadDashboard(),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const MainDrawer(),
        body: _MainScreenBody(scaffoldKey: _scaffoldKey),
      ),
    );
  }
}

class _MainScreenBody extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const _MainScreenBody({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainScreenCubit, MainScreenState>(
        builder: (context, state) {
          if (state is MainScreenLoaded) {
            final dashboard = state.dashboard;

            return BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return Column(
                  children: [
                    EmployeeHeader(
                      name: dashboard.employeeName,
                      jobTitle: dashboard.jobTitle,
                      profileImageUrl: dashboard.avatar,
                      onMenuTap: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 2.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Welcome
                            Text(
                              "welcome_back".tr(),
                              style: AppTextStyle.subHeadline.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            SizedBox(height: .5.h),

                            Text(
                              "attendance_glance".tr(),
                              style: AppTextStyle.body.copyWith(),
                            ),

                            AppSizedBox.h2,

                            /// Today Status
                            const TodayStatusCard(
                              checkIn: "10:05",
                              checkOut: "--",
                              workedHours: "3h",
                            ),

                            AppSizedBox.h3,

                            /// Attendance Summary
                            AttendanceSummaryCard(
                              presentDays: dashboard.presentDays,
                              leaveDays: dashboard.leaveDays,
                              allowedLateHours: dashboard.lateHoursAllowed,
                            ),

                            AppSizedBox.h3,

                            /// Late Hours
                            LateHoursCard(
                              lateHoursUsed: dashboard.lateHoursUsed,
                              lateHoursAllowed: dashboard.lateHoursAllowed,
                            ),

                            AppSizedBox.h3,

                            /// Weekly report
                            WeeklyReportList(logs: dashboard.weeklyReport),



                            AppSizedBox.h3,
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }

          if (state is MainScreenError) {
            return Center(child: Text(state.message));
          }

          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        },
      ),
    );
  }
}
