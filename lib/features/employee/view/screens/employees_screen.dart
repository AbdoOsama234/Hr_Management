import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/%20sheard/componnents/app_shimmers.dart';
import 'package:hr_manegement/%20sheard/componnents/screen_builder/screen_builder.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/features/employee/data/models/branches_model.dart';
import 'package:hr_manegement/features/employee/data/models/employees_model.dart';

import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/custom_button.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import '../../../../ sheard/componnents/show_flutter_snackbar.dart';
import '../../../../core/app_router.dart';
import '../../controller/employee_cubit.dart';
import '../../controller/employee_state.dart';
import '../widgets/employee_card.dart';

class EmployeesScreen extends StatelessWidget {
final BrancheModel brancheModel;

  const EmployeesScreen({super.key, required this.brancheModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployeeCubit>()..getAllUsers(brancheModel.id.toString()),
      lazy: false,
      child: Scaffold(
        appBar: CustomAppBar(title: ""),
        backgroundColor: AppColors.backGround,
        body: BlocBuilder<EmployeeCubit, EmployeeState>(
          builder: (context, state) {
            var cubit = EmployeeCubit.get(context);
            return CustomApiBuilderView(
              isLoading: state is GetAllUsersLoading,
              isError: state is GetAllUsersError,
              isEmpty: cubit.users.isNotEmpty,
              contentBuilder: () => allUsers(cubit.users),
              loadingWidget: AppShimmer.grid(),
              onRetry: () => cubit.getAllBranches(),
              errorMessage: state is GetAllBranchesError ? state.error : null,
            );
          },
        ),
      ),
    );
  }

  ListView allUsers(List<UsersModel> users) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 100)),
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
            user: user,
            branche:brancheModel ,
            onTrack: () {
              Navigator.pushNamed(
                context,
                Routes.tracking,
                arguments: user.name,
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
                                      border: Border.all(
                                        color: AppColors.borderColor,
                                      ),
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
                                          cubit.submitAttendance(
                                            user.id.orZero(),
                                          );
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
            },
          ),
        );
      },
    );
  }
}
