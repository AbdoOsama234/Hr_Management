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
import '../../controller/business_trip_cubit.dart';
import '../../controller/business_trip_state.dart';
import '../../data/models/business_trip_model.dart';
import '../../../../my_app.dart';
import '../../data/models/business_trip_request.dart';
import 'business_trip_request_form.dart';

class BusinessTripRequestCard extends StatelessWidget {
  final BusinessTripModel trip;

  const BusinessTripRequestCard({super.key, required this.trip});

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
                    color: AppColors.primary.withOpacity(0.6),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '${_formatDate(trip.fromDate)} → ${_formatDate(trip.toDate)}',
                    style: AppTextStyle.hint.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildStatusChip(trip.status),
            ],
          ),

          AppSizedBox.h1,

          /// ⏱ Days
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 4.w,
                color: AppColors.primary.withOpacity(0.6),
              ),
              SizedBox(width: 2.w),
              Text(
                '${trip.daysCount ?? 0} ${'Days'.tr()}',
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
                  trip.requestNotes ?? "",
                  style: AppTextStyle.title.copyWith(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              AppSizedBox.w2,

              /// ✏️ Update
              BlocConsumer<BusinessTripCubit, BusinessTripState>(
                buildWhen: (previous, current) =>
                    current is UpdateTripLoading ||
                    current is UpdateTripSuccess ||
                    current is UpdateTripError,

                listener: (context, state) {
                  if (state is UpdateTripError) {
                    CustomToast.show(
                      message: state.error.orEmpty(),
                      type: ToastType.error,
                    );
                  }
                },

                builder: (context, state) {
                  return CustomApiBuilderView(
                    isLoading:
                        state is UpdateTripLoading && state.id == trip.id,

                    isError: state is UpdateTripError,

                    showErrorView: false,
                    showEmptyView: false,

                    loadingWidget: LoaderWidget(size: 40),

                    contentBuilder: () => updateIcon(),

                    onRetry: () {
                      updateIcon();
                    },

                    errorMessage: state is UpdateTripError ? state.error : null,
                  );
                },
              ),
              AppSizedBox.w2,
              BlocConsumer<BusinessTripCubit, BusinessTripState>(
                buildWhen: (previous, current) =>
                    current is DeleteTripLoading ||
                    current is DeleteTripSuccess ||
                    current is DeleteTripError,
                builder: (context, state) {
                  var cubit = BusinessTripCubit.get(context);
                  return CustomApiBuilderView(
                    isLoading:
                        state is DeleteTripLoading && state.id == trip.id,
                    isError: state is DeleteTripError,
                    showErrorView: false,
                    showEmptyView: false,
                    loadingWidget: LoaderWidget(size: 40),
                    contentBuilder: () => deleteIcon(),
                    onRetry: () => cubit.deleteTrip(trip.id!),
                    errorMessage: state is DeleteTripError ? state.error : null,
                  );
                },
                listener: (BuildContext context, BusinessTripState state) {
                  if (state is DeleteTripError) {
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
          icon: Icon(Icons.delete, color: AppColors.primary),
          onTap: () {
            showAppOptionBottomSheet(
              context: context,
              title: "Are you sure you want to delete this request?".tr(),

              option1: BottomSheetOption(
                title: "Yes".tr(),
                backGroundColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                  context.read<BusinessTripCubit>().deleteTrip(trip.id!);
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
          icon: Icon(Icons.edit, color: AppColors.primary),
          onTap: () {
            showAppBottomSheet(
              context: context,
              title: 'Update Business Trip Request'.tr(),
              body: BusinessTripRequestForm(
                trip: trip,
                buttonText: 'Update Request'.tr(),
                onSubmit: (startDate, endDate, days, reason) {
                  context.read<BusinessTripCubit>().updateTrip(
                    id: trip.id!,
                    model: BusinessTripRequest(
                      tripType: "business",
                      fromDate: formatDateForApi(startDate),
                      toDate: formatDateForApi(endDate),
                      daysCount: days,
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
        color: color.withOpacity(MyApp.isDark ? 0.15 : 0.1),
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
