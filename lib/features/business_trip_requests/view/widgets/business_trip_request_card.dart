import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';

import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../../../ sheard/componnents/icon_button.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import '../../../../core/text_style.dart';
import '../../controller/business_trip_cubit.dart';
import '../../data/models/business_trip_model.dart';
import '../../../../my_app.dart';
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

              /// ✏️ Edit
              AppIcon(
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
                          tripType: trip.tripType ?? "business",
                          fromDate: startDate,
                          toDate: endDate,
                          days: days,
                          reason: reason,
                        );
                      },
                    ),
                  );
                },
              ),

              AppSizedBox.w2,

              /// 🗑 Delete
              AppIcon(
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
              ),
            ],
          ),
        ],
      ),
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
}
