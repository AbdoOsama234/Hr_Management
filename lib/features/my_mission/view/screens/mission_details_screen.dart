import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/text_style.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/screen_builder/screen_builder.dart';
import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../controller/my_mission_cubit.dart';
import '../../controller/my_mission_state.dart';
import '../../data/models/my_mission_request.dart';

class MissionDetailsScreen extends StatelessWidget {
  final int missionId;

  const MissionDetailsScreen({super.key, required this.missionId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyMissionCubit, MyMissionState>(
      builder: (context, state) {
        final cubit = MyMissionCubit.get(context);
        final details = cubit.missionDetails;

        return Scaffold(
          appBar: CustomAppBar(title: 'mission_details'.tr()),
          body: CustomApiBuilderView(
            isLoading: state is GetMissionDetailsLoading,
            isError: state is GetMissionDetailsError,
            isEmpty: details == null && state is! GetMissionDetailsLoading,
            errorMessage: state is GetMissionDetailsError ? state.error : null,
            onRetry: () => cubit.getMissionDetails(missionId),
            contentBuilder: () {
              if (details == null) return const SizedBox();
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoCard(details),
                    AppSizedBox.h3,
                    Text(
                      'mission_notes'.tr(),
                      style: AppTextStyle.title.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    AppSizedBox.h1,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.backGround2,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: Text(
                        details.desc ?? details.subject ?? '',
                        style: AppTextStyle.body.copyWith(height: 1.5),
                      ),
                    ),
                    AppSizedBox.h4,
                    _buildStatusSection(context, cubit, details),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(details) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _buildRowInfo(Icons.tag, 'SR', details.sr ?? ''),
          const Divider(height: 30),
          _buildRowInfo(
            Icons.calendar_today,
            'start_date'.tr(),
            details.startDate != null ? dateFoemated(details.startDate!) : '-',
          ),
          const SizedBox(height: 15),
          _buildRowInfo(
            Icons.event,
            'end_date'.tr(),
            details.endDate != null ? dateFoemated(details.endDate!) : '-',
          ),
          const SizedBox(height: 15),
          _buildRowInfo(
            Icons.priority_high,
            'mission_importance'.tr(),
            _getPriorityLabel(details.priorityId),
            valueColor: _getPriorityColor(details.priorityId),
          ),
        ],
      ),
    );
  }

  Widget _buildRowInfo(
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: AppTextStyle.hint.copyWith(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyle.body.copyWith(
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppColors.textMain,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection(context, cubit, details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'change_status'.tr(),
          style: AppTextStyle.title.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        AppSizedBox.h2,
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [1, 2, 3, 4].map((statusId) {
            final isSelected = details.taskStatusId == statusId;
            return InkWell(
              onTap: () {
                cubit.updateMission(
                  id: details.id!,
                  model: MyMissionRequest(
                    taskStatusId: statusId,
                    priorityId: details.priorityId,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? _getStatusColor(statusId)
                      : AppColors.backGround2,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? _getStatusColor(statusId)
                        : AppColors.borderColor,
                  ),
                ),
                child: Text(
                  _getStatusLabel(statusId),
                  style: AppTextStyle.smallBody.copyWith(
                    color: isSelected ? Colors.white : AppColors.textMain,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
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
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
