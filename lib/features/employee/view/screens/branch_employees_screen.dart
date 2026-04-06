import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/custom_button.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/empty_screen.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import '../../../../ sheard/componnents/show_flutter_snackbar.dart';
import '../../../../core/app_router.dart';
import '../../controller/employee_cubit.dart';
import '../../controller/employee_state.dart';
import '../widgets/employee_card.dart';
import '../../../../core/app_assets.dart';

class BranchEmployeesScreen extends StatelessWidget {
  final String branchName;

  const BranchEmployeesScreen({
    super.key,
    required this.branchName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<EmployeeCubit>()..getEmployeesByBranch(branchName),
      child: Scaffold(
        appBar: CustomAppBar(
          title: branchName,
        ),
        backgroundColor: AppColors.backGround,
        body: BlocBuilder<EmployeeCubit, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeLoading) {
              return const Center(child: LoaderWidget());
            }

            if (state is EmployeeError) {
              return Center(
                child: Text(
                  state.message,
                  style:
                  AppTextStyle.body.copyWith(color: AppColors.error),
                ),
              );
            }

            if (state is EmployeeLoaded) {
              if (state.employees.isEmpty) {
                return EmptyScreen(
                  title: "no_employees_found".tr(),
                  description: "no_employees_found_desc".tr(),
                  image: AppAssets.appLogo,
                  onTap: () {
                    context
                        .read<EmployeeCubit>()
                        .getEmployeesByBranch(branchName);
                  },
                );
              }

              return ListView.builder(
                padding:
                EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                physics: const BouncingScrollPhysics(),
                itemCount: state.employees.length,
                itemBuilder: (context, index) {
                  final employee = state.employees[index];

                  return TweenAnimationBuilder<double>(
                    duration:
                    Duration(milliseconds: 300 + (index * 100)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: EmployeeCard(
                      employee: employee,
                      onTrack: () {
                        Navigator.pushNamed(
                          context,
                          Routes.tracking,
                          arguments: employee.name,
                        );
                      },

                      /// ✅ FIXED Attendance
                      onAttendance: () {
                        final cubit = context.read<EmployeeCubit>();

                        cubit.initAttendanceForm();

                        final notesController = TextEditingController();

                        showAppBottomSheet(
                          context: context,
                          title: "attendance".tr(),
                          body: Builder(
                            builder: (sheetContext) {
                              return BlocProvider.value(
                                value: cubit,
                                child: BlocListener<EmployeeCubit, EmployeeState>(
                                  listener: (context, state) {
                                    /// ✅ Success باستخدام flag
                                    if (state is EmployeeLoaded && state.isSuccess) {
                                      Navigator.pop(sheetContext);

                                      showFlutterSnackBar(
                                        message: "attendance_submitted".tr(),
                                      );
                                    }

                                  },
                                  child: BlocBuilder<EmployeeCubit, EmployeeState>(
                                    builder: (context, state) {
                                      if (state is! EmployeeLoaded) {
                                        return const SizedBox();
                                      }

                                      return Column(
                                        children: [
                                          /// 📅 Date
                                          GestureDetector(
                                            onTap: () async {
                                              final picked = await showDatePicker(
                                                context: context,
                                                initialDate:
                                                state.selectedDate ?? DateTime.now(),
                                                firstDate: DateTime(2020),
                                                lastDate: DateTime(2100),
                                              );

                                              if (picked != null) {
                                                cubit.changeDate(picked);
                                              }
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(3.w),
                                              decoration: BoxDecoration(
                                                border:
                                                Border.all(color: AppColors.borderColor),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                DateFormat.yMMMd().format(
                                                  state.selectedDate ?? DateTime.now(),
                                                ),
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 2.h),

                                          /// 📝 Notes
                                          CustomTextField(
                                            controller: notesController,
                                            hint: "enter_notes".tr(),
                                            type: TextInputType.multiline,
                                            max: 3,
                                            validator: (v) => null,
                                            onChange: (v) {
                                              cubit.changeNotes(v);
                                            },
                                          ),

                                          SizedBox(height: 2.h),

                                          /// 🚀 Submit
                                          state.isSubmitting
                                              ? const CircularProgressIndicator()
                                              : CustomButton(
                                            onTap: () {
                                              cubit.submitAttendance(employee.id);
                                            },
                                            text: "confirm".tr(),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}