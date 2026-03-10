import 'package:flutter/material.dart';
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

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MainScreenCubit>()..loadDashboard(),
      child: const _MainScreenBody(),
    );
  }
}

class _MainScreenBody extends StatelessWidget {
  const _MainScreenBody();

  @override
  Widget build(BuildContext context) {
    final isDark = context.select((AppCubit c) => c.isDark);

    final scaffoldBg =
    isDark ? AppColors.backGround : const Color(0xFFF6F7FB);

    final textColor =
    isDark ? AppColors.textMain : const Color(0xFF1A1A2E);

    final subtextColor =
    isDark ? AppColors.textSub : const Color(0xFF6A6A8A);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: scaffoldBg,
        body: BlocBuilder<MainScreenCubit, MainScreenState>(
          builder: (context, state) {
            if (state is MainScreenLoaded) {
              final dashboard = state.dashboard;

              return Column(
                children: [
                  EmployeeHeader(
                    name: dashboard.employeeName,
                    jobTitle: dashboard.jobTitle,
                    profileImageUrl: dashboard.avatar,
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
                            "مرحباً بعودتك 👋",
                            style: AppTextStyle.subHeadline.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          SizedBox(height: .5.h),

                          Text(
                            "نظرة سريعة على حضورك هذا الشهر",
                            style: AppTextStyle.body.copyWith(
                              color: subtextColor,
                            ),
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
                            allowedLateHours:
                            dashboard.lateHoursAllowed,
                          ),

                          AppSizedBox.h3,

                          /// Late Hours
                          LateHoursCard(
                            lateHoursUsed: dashboard.lateHoursUsed,
                            lateHoursAllowed:
                            dashboard.lateHoursAllowed,
                          ),

                          AppSizedBox.h3,

                          /// Weekly report
                          WeeklyReportList(
                            logs: dashboard.weeklyReport,
                          ),

                          AppSizedBox.h3,

                          /// More Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                AppColors.primary.withOpacity(.08),
                                foregroundColor: AppColors.primary,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                  vertical: 1.8.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(14),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "عرض المزيد",
                                    style: AppTextStyle.title.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 4.w,
                                    color: AppColors.primary,
                                  )
                                ],
                              ),
                            ),
                          ),

                          AppSizedBox.h3
                        ],
                      ),
                    ),
                  )
                ],
              );
            }

            if (state is MainScreenError) {
              return Center(
                child: Text(state.message),
              );
            }

            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          },
        ),
      ),
    );
  }
}