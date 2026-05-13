import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../../../ sheard/componnents/icon_button.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import '../../../../my_app.dart';
import '../../controller/permission_cubit.dart';
import '../../data/models/permission_model.dart';
import 'permission_request_form.dart';

class PermissionRequestCard extends StatelessWidget {
  final PermissionModel request;

  const PermissionRequestCard({super.key, required this.request});

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
                    '${dateFoemated(request.fromDatetime ?? '')} \u2192 ${dateFoemated(request.toDatetime ?? '')}',
                    style: AppTextStyle.hint.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildStatusChip(request.status ?? ''),
            ],
          ),
          AppSizedBox.h1,
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 4.w,
                color: AppColors.primary.withOpacity(0.6),
              ),
              SizedBox(width: 2.w),
              Text(
                '${request.hours} ${'Hours'.tr()}',
                style: AppTextStyle.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          AppSizedBox.h2,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  request.requestNotes ?? '',
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
                    title: 'Update Permission Request'.tr(),
                    body: PermissionRequestForm(
                      request: request,
                      buttonText: 'Update Request'.tr(),
                      onSubmit: (model) {
                        context.read<PermissionCubit>().updatePermission(
                          id: request.id!,
                          model: model,
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
                      backGroundColor: Colors.transparent,

                      onTap: () {
                        context.read<PermissionCubit>().deletePermission(
                          request.id!,
                        );
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

  Widget _buildStatusChip(String status) {
    Color color;
    String label;

    switch (status.toLowerCase()) {
      case 'pending':
      case '':
        color = AppColors.orange;
        label = 'status_pending'.tr();
        break;
      case 'approved':
      case 'accepted':
        color = AppColors.mintGreen;
        label = 'status_approved'.tr();
        break;
      case 'rejected':
        color = AppColors.rose;
        label = 'status_rejected'.tr();
        break;
      default:
        color = AppColors.orange;
        label = status;
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
