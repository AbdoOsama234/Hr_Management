import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/empty_screen.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
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
      create: (context) => getIt<EmployeeCubit>()..getEmployeesByBranch(branchName),
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
                  style: AppTextStyle.body.copyWith(color: AppColors.error),
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
                    context.read<EmployeeCubit>().getEmployeesByBranch(branchName);
                  },
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                physics: const BouncingScrollPhysics(),
                itemCount: state.employees.length,
                itemBuilder: (context, index) {
                  final employee = state.employees[index];
                  
                  /// 🎁 Bonus: Slight animation for list items
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
                      employee: employee,
                      onTrack: () {
                        Navigator.pushNamed(
                          context,
                          Routes.tracking,
                          arguments: employee.name,
                        );
                      },
                    ),                  );
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
