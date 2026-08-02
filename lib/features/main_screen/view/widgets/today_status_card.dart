import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/%20sheard/componnents/app_shimmers.dart';
import 'package:hr_manegement/%20sheard/componnents/screen_builder/screen_builder.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_cubit/app_cubit.dart';
import 'package:hr_manegement/core/app_cubit/app_state.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:hr_manegement/my_app.dart';
import 'package:hr_manegement/features/main_screen/controller/main_screen_cubit.dart';

class TodayStatusCard extends StatelessWidget {
  const TodayStatusCard({super.key});

  String _formatTime(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.isEmpty) return "--";

    try {
      final parts = dateTimeStr.split(' ');

      if (parts.length > 1) {
        final timeParts = parts[1].split(':');

        if (timeParts.length > 1) {
          return "${timeParts[0]}:${timeParts[1]}";
        }
      }

      return dateTimeStr;
    } catch (_) {
      return "--";
    }
  }

  String _formatWorkedHours(int? totalMinutes) {
    if (totalMinutes == null) return "--";

    final hours = totalMinutes ~/ 60;
    final mins = totalMinutes % 60;

    if (hours == 0 && mins == 0) return "--";

    return "${hours}h ${mins}m";
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String label;

    switch (status.toLowerCase()) {
      case "present":
      case "complete":
      case "done":
        color = AppColors.mintGreen;
        label = status.tr();
        break;

      case "incomplete":
      case "pending":
        color = AppColors.green;
        label = status.tr();
        break;

      case "absent":
      case "rejected":
        color = AppColors.rose;
        label = status.tr();
        break;

      default:
        color = AppColors.primary;
        label = status.tr();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: MyApp.isDark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: AppTextStyle.smallBody.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      buildWhen: (previous, current) =>
          current is GetAttendanceLoading ||
          current is GetAttendanceSuccess ||
          current is GetAttendanceError,
      builder: (context, state) {
        final attendance = context.read<MainCubit>().attendance;

        final checkIn = _formatTime(attendance?.firstIn);
        final checkOut = _formatTime(attendance?.lastOut);
        final workedHours = _formatWorkedHours(attendance?.totalWorkMinutes);

        return CustomApiBuilderView(
          isLoading: state is GetAttendanceLoading,
          loadingWidget: AppShimmer.box(
            height: 18.h,
            width: double.infinity,
            radius: 20,
          ),

          isError: state is GetAttendanceError,

          showErrorView: false,
          showEmptyView: false,

          errorMessage: state is GetAttendanceError ? state.error : null,

          onRetry: () {
            context.read<MainCubit>().getAttendance();
          },

          contentBuilder: () {
            return BlocBuilder<AppCubit, AppState>(
              builder: (context, appState) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backGround2,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title & Status Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: MyApp.isDark ? .12 : .08,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.today_rounded,
                                  color: AppColors.primary,
                                  size: 5.w,
                                ),
                              ),

                              SizedBox(width: 2.5.w),

                              Text(
                                "today_status".tr(),
                                style: AppTextStyle.title.copyWith(
                                  color: AppColors.textMain,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),

                          if (attendance?.status != null)
                            _buildStatusChip(attendance!.status!),
                        ],
                      ),

                      SizedBox(height: 2.5.h),

                      /// Status Row
                      Row(
                        children: [
                          _buildItem(
                            icon: Icons.login_rounded,
                            label: "check_in".tr(),
                            value: checkIn,
                            color: AppColors.primary,
                            textColor: AppColors.textMain,
                            subtextColor: AppColors.textSub,
                            isDark: MyApp.isDark,
                          ),

                          SizedBox(width: 2.w),

                          _buildItem(
                            icon: Icons.logout_rounded,
                            label: "check_out".tr(),
                            value: checkOut,
                            color: AppColors.primary,
                            textColor: AppColors.textMain,
                            subtextColor: AppColors.textSub,
                            isDark: MyApp.isDark,
                          ),

                          SizedBox(width: 2.w),

                          _buildItem(
                            icon: Icons.access_time_filled,
                            label: "working_hours".tr(),
                            value: workedHours,
                            color: AppColors.primary,
                            textColor: AppColors.textMain,
                            subtextColor: AppColors.textSub,
                            isDark: MyApp.isDark,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color textColor,
    required Color subtextColor,
    required bool isDark,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 2.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: isDark ? .06 : .04),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 5.w),

            SizedBox(height: .5.h),

            Text(
              label,
              style: AppTextStyle.smallBody.copyWith(color: subtextColor),
            ),

            SizedBox(height: .3.h),

            Text(
              value,
              style: AppTextStyle.body.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
