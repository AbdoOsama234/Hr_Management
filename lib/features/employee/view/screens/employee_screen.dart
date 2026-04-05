import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import '../../../../core/app_router.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../widgets/branch_card.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// 🏢 Defined branches for the HR System
    final branches = [
      _BranchData(
        name: 'branch_riyadh',
        icon: Icons.business_rounded,
        color: AppColors.primary,
      ),
      _BranchData(
        name: 'branch_jeddah',
        icon: Icons.location_city_rounded,
        color: AppColors.green,
      ),
      _BranchData(
        name: 'branch_digital_tracks',
        icon: Icons.hub_rounded,
        color: AppColors.blue,
      ),
      _BranchData(
        name: 'branch_cairo',
        icon: Icons.apartment_rounded,
        color: AppColors.orange,
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'company_branches'.tr(),
      ),
      backgroundColor: AppColors.backGround,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔥 Grid View to display the 4 branches
              Expanded(
                child: GridView.builder(
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
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: BranchCard(
                        name: branch.name,
                        icon: branch.icon,
                        iconColor: branch.color,
                        onTap: () {
                          /// → navigate to the branch employees screen using named route
                          Navigator.pushNamed(
                            context,
                            Routes.branchEmployees,
                            arguments: branch.name.tr(),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BranchData {
  final String name;
  final IconData icon;
  final Color color;

  _BranchData({
    required this.name,
    required this.icon,
    required this.color,
  });
}
