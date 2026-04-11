import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/%20sheard/componnents/app_shimmers.dart';
import 'package:hr_manegement/%20sheard/componnents/screen_builder/screen_builder.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/features/employee/controller/employee_cubit.dart';
import 'package:hr_manegement/features/employee/controller/employee_state.dart';
import 'package:hr_manegement/features/employee/data/models/branches_model.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../widgets/branch_card.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// 🏢 Defined branches for the HR System

    return BlocProvider(
      create: (context) => getIt<EmployeeCubit>()..getAllBranches(),
      lazy: false,
      child: Scaffold(
        appBar: CustomAppBar(title: 'company_branches'.tr()),
        backgroundColor: AppColors.backGround,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: BlocBuilder<EmployeeCubit, EmployeeState>(
            builder: (context, state) {
              var cubit = EmployeeCubit.get(context);
              return CustomApiBuilderView(
                isLoading: state is GetAllBranchesLoading,
                isError: state is GetAllBranchesError,
                isEmpty: cubit.branches.isEmpty,
                contentBuilder: () => branchesList(cubit.branches),
                loadingWidget: AppShimmer.grid(),
                onRetry: () => cubit.getAllBranches(),
                errorMessage: state is GetAllBranchesError ? state.error : null,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget branchesList(List<BrancheModel> branches) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 2.h,
        childAspectRatio: 0.85,
      ),
      itemCount: branches.length,
      itemBuilder: (context, index) {
        final branch = branches[index];
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 400 + (index * 150)),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.scale(scale: value, child: child);
          },
          child: BranchCard(branche: branch),
        );
      },
    );
  }
}
