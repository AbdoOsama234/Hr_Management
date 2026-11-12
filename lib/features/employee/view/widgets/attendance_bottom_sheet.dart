import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/%20sheard/componnents/custom_button.dart';
import 'package:hr_manegement/%20sheard/componnents/show_app_toast.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:hr_manegement/features/employee/controller/employee_cubit.dart';
import 'package:hr_manegement/features/employee/controller/employee_state.dart';
import 'package:hr_manegement/features/employee/data/models/branches_model.dart';
import 'package:hr_manegement/features/employee/data/models/employees_model.dart';
import 'package:intl/intl.dart' as intl;

class AttendanceBottomSheet extends StatelessWidget {
  final UsersModel user;
  final BrancheModel branche;

  const AttendanceBottomSheet({
    super.key,
    required this.user,
    required this.branche,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeCubit, EmployeeState>(
      listenWhen: (previous, current) => current is AttendanceFormState,
      listener: (context, state) {
        if (state is AttendanceFormState) {
          if (state.isSuccess) {
            Navigator.pop(context);
            CustomToast.show(
              message: state.mode == 'check_out'
                  ? 'checkout_submitted'.tr()
                  : 'attendance_submitted'.tr(),
              type: ToastType.success,
            );
          } else if (state.error != null && !state.isSubmitting) {
            CustomToast.show(message: state.error!, type: ToastType.error);
          }
        }
      },
      buildWhen: (previous, current) => current is AttendanceFormState,
      builder: (context, state) {
        if (state is! AttendanceFormState) {
          return const SizedBox.shrink();
        }

        final cubit = context.read<EmployeeCubit>();

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// 👤 Employee Info Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: AppColors.backGround,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.5.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      color: AppColors.primary,
                      size: 6.w,
                    ),
                  ),
                  SizedBox(width: 3.5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name.orEmpty(),
                          style: AppTextStyle.title.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                            color: AppColors.textMain,
                          ),
                        ),
                        SizedBox(height: 0.4.h),
                        Text(
                          branche.localName,
                          style: AppTextStyle.body.copyWith(
                            color: AppColors.textSub,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            AppSizedBox.h2,

            /// 🔄 Attendance Mode Segment (Check In / Check Out)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.backGround,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => cubit.updateAttendanceMode('check_in'),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.2.h),
                        decoration: BoxDecoration(
                          color: state.mode == 'check_in'
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'check_in'.tr(),
                            style: AppTextStyle.body.copyWith(
                              color: state.mode == 'check_in'
                                  ? Colors.white
                                  : AppColors.textSub,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => cubit.updateAttendanceMode('check_out'),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.2.h),
                        decoration: BoxDecoration(
                          color: state.mode == 'check_out'
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'check_out'.tr(),
                            style: AppTextStyle.body.copyWith(
                              color: state.mode == 'check_out'
                                  ? Colors.white
                                  : AppColors.textSub,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            AppSizedBox.h2,

            /// 📅 Dates Row (From Date & To Date)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'start_date'.tr(),
                        style: AppTextStyle.body.copyWith(
                          color: AppColors.textSub,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 0.8.h),
                      InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: state.dateFrom,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2035),
                          );
                          if (picked != null) {
                            cubit.updateAttendanceDateFrom(picked);
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            vertical: 1.3.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.backGround,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_rounded,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Text(
                                  intl.DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(state.dateFrom),
                                  style: AppTextStyle.body.copyWith(
                                    color: AppColors.textMain,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'end_date'.tr(),
                        style: AppTextStyle.body.copyWith(
                          color: AppColors.textSub,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 0.8.h),
                      InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: state.dateTo,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2035),
                          );
                          if (picked != null) {
                            cubit.updateAttendanceDateTo(picked);
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            vertical: 1.3.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.backGround,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_rounded,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Text(
                                  intl.DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(state.dateTo),
                                  style: AppTextStyle.body.copyWith(
                                    color: AppColors.textMain,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            AppSizedBox.h2,

            /// ⏰ Time Picker Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'attendance_time'.tr(),
                  style: AppTextStyle.body.copyWith(
                    color: AppColors.textSub,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 0.8.h),
                InkWell(
                  onTap: () async {
                    final timeParts = state.time.split(':');
                    final initialTime = timeParts.length == 2
                        ? TimeOfDay(
                            hour: int.tryParse(timeParts[0]) ?? 9,
                            minute: int.tryParse(timeParts[1]) ?? 0,
                          )
                        : const TimeOfDay(hour: 9, minute: 0);

                    final picked = await showTimePicker(
                      context: context,
                      initialTime: initialTime,
                    );

                    if (picked != null) {
                      final formatted =
                          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                      cubit.updateAttendanceTime(formatted);
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.5.w,
                      vertical: 1.3.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backGround,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 2.5.w),
                        Expanded(
                          child: Text(
                            state.time,
                            style: AppTextStyle.body.copyWith(
                              color: AppColors.textMain,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textSub,
                          size: 5.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            AppSizedBox.h2,

            // /// ⚙️ Options (Working days only & Overwrite)
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            //   decoration: BoxDecoration(
            //     color: AppColors.backGround,
            //     borderRadius: BorderRadius.circular(12),
            //     border: Border.all(color: AppColors.borderColor),
            //   ),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           Expanded(
            //             child: Text(
            //               'working_days_only'.tr(),
            //               style: AppTextStyle.body.copyWith(
            //                 color: AppColors.textMain,
            //                 fontWeight: FontWeight.w500,
            //                 fontSize: 11.sp,
            //               ),
            //             ),
            //           ),
            //           Switch.adaptive(
            //             value: state.workingDaysOnly,
            //             activeColor: AppColors.primary,
            //             onChanged: (val) => cubit.updateWorkingDaysOnly(val),
            //           ),
            //         ],
            //       ),
            //       Divider(
            //         height: 1,
            //         color: AppColors.dividerColor,
            //       ),
            //       Row(
            //         children: [
            //           Expanded(
            //             child: Text(
            //               'overwrite_existing'.tr(),
            //               style: AppTextStyle.body.copyWith(
            //                 color: AppColors.textMain,
            //                 fontWeight: FontWeight.w500,
            //                 fontSize: 11.sp,
            //               ),
            //             ),
            //           ),
            //           Switch.adaptive(
            //             value: state.overwrite,
            //             activeColor: AppColors.primary,
            //             onChanged: (val) => cubit.updateOverwrite(val),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            // AppSizedBox.h3,

            /// 🚀 Submit Button
            CustomButton(
              text: 'confirm'.tr(),
              isLoading: state.isSubmitting,
              onTap: () => cubit.createAttendance(),
            ),
          ],
        );
      },
    );
  }
}
