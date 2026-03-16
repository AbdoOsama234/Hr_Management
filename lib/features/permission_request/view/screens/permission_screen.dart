import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/features/componnents/custom_app_bar.dart';
import 'package:hr_manegement/features/componnents/empty_screen.dart';
import 'package:hr_manegement/features/componnents/loading_widget.dart';
import 'package:hr_manegement/features/componnents/show_bottom_sheet.dart';

import '../../controller/permission_cubit.dart';
import '../../controller/permission_state.dart';
import '../widgets/permission_request_card.dart';
import '../widgets/permission_request_form.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  void _showRequestForm(BuildContext context) {
    showAppBottomSheet(
      context: context,
      title: 'Request Permission'.tr(),
      body: PermissionRequestForm(
        onSubmit: (startDate, endDate, hours, reason) {
          context.read<PermissionCubit>().addPermissionRequest(
            startDate,
            endDate,
            hours,
            reason,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PermissionCubit()..loadRequests(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Permission Requests'.tr()),
        body: BlocBuilder<PermissionCubit, PermissionState>(
          builder: (context, state) {
            if (state is PermissionLoading) {
              return const Center(child: LoaderWidget());
            }

            if (state is PermissionEmpty) {
              return EmptyScreen(
                title: 'No Permission Requests'.tr(),
                description: "You haven't submitted any permission requests yet."
                    .tr(),
                buttonText: 'Request Permission'.tr(),
                image: AppAssets.appLogo,

                onTap: () => _showRequestForm(context),
              );
            }

            if (state is PermissionLoaded) {
              return RefreshIndicator(
                onRefresh: () => context.read<PermissionCubit>().loadRequests(),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  itemCount: state.requests.length,
                  itemBuilder: (context, index) {
                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 300 + (index * 100)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeIn,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: PermissionRequestCard(request: state.requests[index]),
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
        floatingActionButton: BlocBuilder<PermissionCubit, PermissionState>(
          builder: (context, state) {
            if (state is PermissionLoaded) {
              return FloatingActionButton(
                onPressed: () => _showRequestForm(context),
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.add, color: Colors.white),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
