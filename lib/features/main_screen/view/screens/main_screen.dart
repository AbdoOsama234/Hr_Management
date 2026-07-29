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
import 'package:hr_manegement/features/my_mission/controller/my_mission_cubit.dart';
import 'package:hr_manegement/features/my_mission/controller/my_mission_state.dart';

import '../../../../core/helpers/background_tracking_services.dart';
import '../../../../ sheard/componnents/app_shimmers.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/screen_builder/screen_builder.dart';
import '../../../../ sheard/componnents/show_app_toast.dart';
import '../../../business_trip_requests/controller/business_trip_cubit.dart';
import '../../../my_mission/view/widgets/mission_item_card.dart';
import '../../../notifications/view/screens/notifications_screen.dart';

import '../../../profile/controller/profile_cubit.dart';
import '../../controller/main_screen_cubit.dart';

import '../widgets/employee_header.dart';
import '../widgets/today_status_card.dart';
import '../widgets/main_drawer.dart';
import '../widgets/admin_instructions_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class MainScreenn extends StatefulWidget {
  const MainScreenn({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<MainCubit>()
            ..getInstructions()
            ..loadDashboard()
            ..getAttendance(),
        ),
        BlocProvider(
          create: (_) => getIt<MyMissionCubit>()..getAllMissions(),
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const MainDrawer(),
        body: _MainScreenBody(scaffoldKey: _scaffoldKey),
      ),
    );
  }
}

class _MainScreenBody extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const _MainScreenBody({required this.scaffoldKey});

  @override
  State<_MainScreenBody> createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<_MainScreenBody> {
  @override
  void initState() {
    super.initState();
    //start for background tracking
    BackgroundTrackingManager.start();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = MainCubit.get(context);

    return Scaffold(
      body: BlocListener<MainCubit, MainState>(
        listener: (context, state) {
          if (state is MainScreenLoaded) {
            /// 🔥 هنا بنبعت الداتا للـ ProfileCubit
            context.read<ProfileCubit>().loadProfile(state);
          }
        },
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            // final dashboard = state.dashboard;

            return BlocBuilder<AppCubit, AppState>(
              builder: (context, appState) {
                return Column(
                  children: [
                    /// 🔥 الهيدر بقى reactive
                    EmployeeHeader(
                      onMenuTap: () {
                        widget.scaffoldKey.currentState?.openDrawer();
                      },
                      onNotificationTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationsScreen(),
                          ),
                        );
                      },
                    ),

                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await cubit.loadDashboard();
                          await cubit.getAttendance();
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),

                          ),
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

                              AppSizedBox.h3,

                              /// Admin Instructions
                              AdminInstructionsWidget(),
                              AppSizedBox.h3,

                              /// Last Mission
                              BlocBuilder<MyMissionCubit, MyMissionState>(
                                builder: (context, state) {
                                  final missionCubit = context.read<MyMissionCubit>();

                                  if (state is GetAllMissionsLoading) {
                                    return AppShimmer.verticalList();
                                  }

                                  if (missionCubit.missions.isEmpty) {
                                    return const SizedBox();
                                  }

                                  return MyMissionItemCard(
                                    mission: missionCubit.missions.first,
                                    taxt: "آخر مهمة".tr(),
                                    icon: const Icon(
                                      Icons.task_alt,
                                      color: AppColors.primary,
                                    ),
                                  );
                                },
                              ),
                              AppSizedBox.h3,

                              /// Today Status
                              const TodayStatusCard(),

                              /// Attendance Summary
                              // AttendanceSummaryCard(
                              //   presentDays: dashboard.presentDays,
                              //   leaveDays: dashboard.leaveDays,
                              //   allowedLateHours: dashboard.lateHoursAllowed,
                              // ),

                              // AppSizedBox.h3,

                              // /// Late Hours
                              // LateHoursCard(
                              //   lateHoursUsed: dashboard.lateHoursUsed,
                              //   lateHoursAllowed: dashboard.lateHoursAllowed,
                              // ),

                              // /// Weekly Report
                              // WeeklyReportList(logs: dashboard.weeklyReport),
                              AppSizedBox.h3,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
