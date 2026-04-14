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
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../core/app_sized_box.dart';
import '../widgets/branch_card.dart';
class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployeeCubit>(),
      child: const _BranchesScreen(),
    );
  }
}
class _BranchesScreen extends StatefulWidget {
  const _BranchesScreen({super.key});

  @override
  State<_BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<_BranchesScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        EmployeeCubit.get(context).getAllBranches(loadMore: true);
      }
    });
    EmployeeCubit.get(context).getAllBranches();
  }

  @override
  Widget build(BuildContext context) {
    /// 🏢 Defined branches for the HR System

    return Scaffold(
      appBar: CustomAppBar(title: 'company_branches'.tr()),
      backgroundColor: AppColors.backGround,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: BlocBuilder<EmployeeCubit, EmployeeState>(
          buildWhen: (previous, current) =>
          current is GetAllBranchesLoading ||
              current is GetAllBranchesLoaded ||
              current is GetAllBranchesError ||
              current is PaginationLoading,
          builder: (context, state) {
            var cubit = EmployeeCubit.get(context);
            return CustomApiBuilderView(

              isLoading: state is GetAllBranchesLoading,
              isError: state is GetAllBranchesError,
              isEmpty: cubit.branches.isEmpty,
              contentBuilder: ()=>Column(
              children: [
                Expanded(child: branchesList(cubit.branches)),
                AppSizedBox.h1,
                if (state is PaginationLoading)
                  const Center(child: LoaderWidget()),

              ],
            ),
              loadingWidget: AppShimmer.grid(),
              onRetry: () => cubit.getAllBranches(),
              errorMessage: state is GetAllBranchesError ? state.error : null,


            );
          },
        ),
      ),
    );
  }

  Widget branchesList(List<BrancheModel> branches) {
    return GridView.builder(
      controller: ScrollController(),
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
