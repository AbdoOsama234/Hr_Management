import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';

import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../../../ sheard/componnents/icon_button.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/screen_builder/screen_builder.dart';
import '../../../../ sheard/componnents/show_app_toast.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import '../../../../core/text_style.dart';
import '../../controller/holiday_cubit.dart';
import '../../controller/holiday_state.dart';
import '../../data/models/holiday_model.dart';
import '../../../../my_app.dart';
import '../../data/models/holiday_request.dart';
import 'holiday_request_form.dart';

class HolidayRequestCard extends StatelessWidget {
  final HolidayModel holiday;

  const HolidayRequestCard({super.key, required this.holiday});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          /// 📅 Date
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
                    '${_formatDate(holiday.fromDate)} → ${_formatDate(holiday.toDate)}',
                    style: AppTextStyle.hint.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildStatusChip(holiday.status),
            ],
          ),

          AppSizedBox.h1,

          /// ⏱ Days
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 4.w,
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
              SizedBox(width: 2.w),
              Text(
                '${holiday.days ?? "0"} ${'Days'.tr()}',
                style: AppTextStyle.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          AppSizedBox.h2,

          /// 📝 Reason + Actions
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  holiday.requestNotes ?? "",
                  style: AppTextStyle.title.copyWith(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              AppSizedBox.w2,

              /// ✏️ Update
              BlocConsumer<HolidayCubit, HolidayState>(
                buildWhen: (previous, current) =>
                    current is UpdateHolidayLoading ||
                    current is UpdateHolidaySuccess ||
                    current is UpdateHolidayError,

                listener: (context, state) {
                  if (state is UpdateHolidayError) {
                    CustomToast.show(
                      message: state.error.orEmpty(),
                      type: ToastType.error,
                    );
                  }
                },

                builder: (context, state) {
                  return CustomApiBuilderView(
                    isLoading:
                        state is UpdateHolidayLoading && state.id == holiday.id,

                    isError: state is UpdateHolidayError,

                    showErrorView: false,
                    showEmptyView: false,

                    loadingWidget: const LoaderWidget(size: 40),

                    contentBuilder: updateIcon,

                    onRetry: updateIcon,

                    errorMessage: state is UpdateHolidayError
                        ? state.error
                        : null,
                  );
                },
              ),
              AppSizedBox.w2,
              BlocConsumer<HolidayCubit, HolidayState>(
                buildWhen: (previous, current) =>
                    current is DeleteHolidayLoading ||
                    current is DeleteHolidaySuccess ||
                    current is DeleteHolidayError,
                builder: (context, state) {
                  var cubit = HolidayCubit.get(context);
                  return CustomApiBuilderView(
                    isLoading:
                        state is DeleteHolidayLoading && state.id == holiday.id,
                    isError: state is DeleteHolidayError,
                    showErrorView: false,
                    showEmptyView: false,
                    loadingWidget: const LoaderWidget(size: 40),
                    contentBuilder: deleteIcon,
                    onRetry: () => cubit.deleteHoliday(holiday.id!),
                    errorMessage: state is DeleteHolidayError
                        ? state.error
                        : null,
                  );
                },
                listener: (BuildContext context, HolidayState state) {
                  if (state is DeleteHolidayError) {
                    CustomToast.show(
                      message: state.error.orEmpty(),
                      type: ToastType.error,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget deleteIcon() {
    return Builder(
      builder: (context) {
        return AppIcon(
          icon: const Icon(Icons.delete, color: AppColors.primary),
          onTap: () {
            showAppOptionBottomSheet(
              context: context,
              title: "Are you sure you want to delete this request?".tr(),

              option1: BottomSheetOption(
                title: "Yes".tr(),
                backGroundColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                  context.read<HolidayCubit>().deleteHoliday(holiday.id!);
                },
              ),

              option2: BottomSheetOption(
                title: "No".tr(),
                backGroundColor: AppColors.primary,
                textColor: AppColors.white,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget updateIcon() {
    return Builder(
      builder: (context) {
        return AppIcon(
          icon: const Icon(Icons.edit, color: AppColors.primary),
          onTap: () {
            showAppBottomSheet(
              context: context,
              title: 'Update Holiday Request'.tr(),
              body: HolidayRequestForm(
                holiday: holiday,
                buttonText: 'Update Request'.tr(),
                onSubmit: (startDate, endDate, days, reason) {
                  context.read<HolidayCubit>().updateHoliday(
                    id: holiday.id!,
                    model: HolidayRequest(
                      type: "holiday",
                      fromDate: formatDateForApi(startDate),
                      toDate: formatDateForApi(endDate),
                      days: days.toString(),
                      requestNotes: reason,
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return "--";
    try {
      return dateFoemated(date);
    } catch (e) {
      return "--";
    }
  }

  Widget _buildStatusChip(String? status) {
    Color color;
    String label;

    switch (status) {
      case "approved":
        color = AppColors.mintGreen;
        label = 'status_approved'.tr();
        break;
      case "rejected":
        color = AppColors.rose;
        label = 'status_rejected'.tr();
        break;
      default:
        color = AppColors.orange;
        label = 'status_pending'.tr();
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

  String formatDateForApi(DateTime date) {
    return date.toString().split(' ').first;
  }
}
