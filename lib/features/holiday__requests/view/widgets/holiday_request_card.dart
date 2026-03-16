import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:hr_manegement/features/componnents/date_time_widgets/common.dart';
import 'package:hr_manegement/features/componnents/icon_button.dart';
import 'package:hr_manegement/features/componnents/show_bottom_sheet.dart';
import '../../controller/holiday_cubit.dart';
import '../../data/models/holiday_request_model.dart';
import '../../../../my_app.dart';
import 'holiday_request_form.dart';

class HolidayRequestCard extends StatelessWidget {
  final HolidayRequestModel request;

  const HolidayRequestCard({super.key, required this.request});

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
                    '${dateFoemated(request.startDate.toString())} \u2192 ${dateFoemated(request.endDate.toString())}',
                    style: AppTextStyle.hint.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildStatusChip(request.status),
            ],
          ),
          AppSizedBox.h2,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  request.reason,
                  style: AppTextStyle.title.copyWith(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AppSizedBox.w2,
              AppIcon(
                icon: Icon(Icons.edit, color: AppColors.primary),
                onTap: () {
                  showAppBottomSheet(
                    context: context,
                    title: 'Update Holiday Request'.tr(),
                    body: HolidayRequestForm(
                      request: request,
                      buttonText: 'Update Request'.tr(),
                      onSubmit: (startDate, endDate, reason) {
                        context.read<HolidayCubit>().editRequest(
                          request.id,
                          startDate,
                          endDate,
                          reason,
                        );
                      },
                    ),
                  );
                },
              ),

              AppSizedBox.w2,
              AppIcon(
                icon: Icon(Icons.delete, color: AppColors.primary),
                onTap: () {
                  showAppOptionBottomSheet(
                    context: context,
                    title: "Are you sure you want to delete this request?".tr(),
                    option1: BottomSheetOption(
                      title: "Yes".tr(),

                      onTap: () {
                        context.read<HolidayCubit>().deleteRequest(request.id);
                        Navigator.pop(context);
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

  Widget _buildStatusChip(HolidayStatus status) {
    Color color;
    String label;

    switch (status) {
      case HolidayStatus.pending:
        color = AppColors.orange;
        label = 'status_pending'.tr();
        break;
      case HolidayStatus.approved:
        color = AppColors.green;
        label = 'status_approved'.tr();
        break;
      case HolidayStatus.rejected:
        color = AppColors.red;
        label = 'status_rejected'.tr();
        break;
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
