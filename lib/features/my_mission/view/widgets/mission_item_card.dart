import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/screen_builder/screen_builder.dart';
import '../../../../ sheard/componnents/show_app_toast.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import '../../controller/my_mission_state.dart';
import '../../data/models/my_mission_model.dart';
import '../../data/models/my_mission_request.dart';
import '../../controller/my_mission_cubit.dart';
import '../../../../my_app.dart';
import '../screens/mission_details_screen.dart';

class MyMissionItemCard extends StatefulWidget {
  final MyMissionModel mission;
  final String? taxt;
  final Icon? icon;

  const MyMissionItemCard({
    super.key,
    required this.mission,
    this.taxt,
    this.icon,
  });

  @override
  State<MyMissionItemCard> createState() => _MyMissionItemCardState();
}

class _MyMissionItemCardState extends State<MyMissionItemCard> {
  late int _currentStatusId;

  @override
  void initState() {
    super.initState();
    _currentStatusId = widget.mission.taskStatusId ?? 1;
  }

  @override
  void didUpdateWidget(covariant MyMissionItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mission != widget.mission) {
      _currentStatusId = widget.mission.taskStatusId ?? 1;
    }
  }

  void _showChangeStatusBottomSheet() {
    showAppBottomSheet(
      context: context,
      title: 'change_status'.tr(),
      body: Column(
        children: [1, 2, 3, 4].map((statusId) {
          final isSelected = _currentStatusId == statusId;
          return ListTile(
            title: Text(_getStatusLabel(statusId)),
            trailing: isSelected
                ? const Icon(Icons.check, color: AppColors.primary)
                : null,
            onTap: () {
              setState(() {
                _currentStatusId = statusId;
              });
              Navigator.pop(context);

              // Call the API to update
              context.read<MyMissionCubit>().updateMission(
                id: widget.mission.id!,
                model: MyMissionRequest(
                  taskStatusId: statusId,
                  priorityId: widget.mission.priorityId,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  String _getStatusLabel(int statusId) {
    switch (statusId) {
      case 1:
        return 'status_newTask'.tr();
      case 2:
        return 'status_progressing'.tr();
      case 3:
        return 'status_reviewing'.tr();
      case 4:
        return 'status_completed'.tr();
      default:
        return 'status_newTask'.tr();
    }
  }

  Color _getStatusColor(int statusId) {
    switch (statusId) {
      case 1:
        return Colors.blue;
      case 2:
        return AppColors.orange;
      case 3:
        return AppColors.rose;
      case 4:
        return AppColors.mintGreen;
      default:
        return Colors.blue;
    }
  }

  String _getPriorityLabel(int? priorityId) {
    switch (priorityId) {
      case 1:
        return 'importance_low'.tr();
      case 2:
        return 'importance_medium'.tr();
      case 3:
        return 'importance_high'.tr();
      default:
        return 'importance_low'.tr();
    }
  }

  Color _getPriorityColor(int? priorityId) {
    switch (priorityId) {
      case 1:
        return Colors.blue;
      case 2:
        return AppColors.orange;
      case 3:
        return AppColors.rose;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final cubit = context.read<MyMissionCubit>()
          ..getMissionDetails(widget.mission.id!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: cubit,
              child: MissionDetailsScreen(missionId: widget.mission.id!),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.backGround2,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (widget.icon != null) ...[
                  widget.icon!,
                  SizedBox(width: 2.w),
                ],
                if (widget.taxt != null && widget.taxt!.isNotEmpty)
                  Text(
                    widget.taxt ?? "",
                    style: AppTextStyle.title.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 4.w,
                      color: AppColors.primary.withValues(alpha: 0.6),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      widget.mission.startDate != null
                          ? dateFoemated(widget.mission.startDate!)
                          : (widget.mission.date != null
                                ? dateFoemated(widget.mission.date!)
                                : ''),
                      style: AppTextStyle.hint.copyWith(
                        color: AppColors.textMain,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _buildStatusChip(_currentStatusId),
              ],
            ),

            // SR number
            if (widget.mission.sr != null) ...[
              AppSizedBox.h1,
              Text(
                widget.mission.sr!,
                style: AppTextStyle.hint.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],

            AppSizedBox.h2,
            Text(
              widget.mission.subject ?? '',
              style: AppTextStyle.title.copyWith(
                color: AppColors.textMain,
                fontWeight: FontWeight.w600,
              ),
            ),

            // Date range
            if (widget.mission.startDate != null &&
                widget.mission.endDate != null) ...[
              AppSizedBox.h1,
              Row(
                children: [
                  Icon(
                    Icons.date_range_rounded,
                    size: 4.w,
                    color: AppColors.primary.withValues(alpha: 0.6),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '${dateFoemated(widget.mission.startDate!)} → ${dateFoemated(widget.mission.endDate!)}',
                    style: AppTextStyle.smallBody.copyWith(
                      color: AppColors.textMain,
                    ),
                  ),
                ],
              ),
            ],

            AppSizedBox.h2,
            Row(
              children: [
                _buildPriorityChip(widget.mission.priorityId),
                const Spacer(),

                /// ✏️ Change Status
                BlocConsumer<MyMissionCubit, MyMissionState>(
                  buildWhen: (previous, current) =>
                      current is UpdateMissionLoading ||
                      current is UpdateMissionSuccess ||
                      current is UpdateMissionError,

                  listener: (context, state) {
                    if (state is UpdateMissionError) {
                      CustomToast.show(
                        message: state.error.orEmpty(),
                        type: ToastType.error,
                      );
                    }
                  },

                  builder: (context, state) {
                    return CustomApiBuilderView(
                      isLoading:
                          state is UpdateMissionLoading &&
                          state.id == widget.mission.id,

                      isError: state is UpdateMissionError,

                      showErrorView: false,
                      showEmptyView: false,

                      loadingWidget: const LoaderWidget(size: 40),

                      contentBuilder: changeStatusButton,

                      onRetry: changeStatusButton,

                      errorMessage: state is UpdateMissionError
                          ? state.error
                          : null,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget changeStatusButton() {
    return Builder(
      builder: (context) {
        return InkWell(
          onTap: _showChangeStatusBottomSheet,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.edit, size: 4.w, color: AppColors.primary),
                SizedBox(width: 1.w),
                Text(
                  'change_status'.tr(),
                  style: AppTextStyle.hint.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(int statusId) {
    Color color = _getStatusColor(statusId);
    String label = _getStatusLabel(statusId);

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

  Widget _buildPriorityChip(int? priorityId) {
    Color color = _getPriorityColor(priorityId);
    String label = _getPriorityLabel(priorityId);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: AppTextStyle.hint.copyWith(
          color: color,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
