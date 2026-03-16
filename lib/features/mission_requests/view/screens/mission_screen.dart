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

import '../../controller/mission_cubit.dart';
import '../../controller/mission_state.dart';
import '../widgets/mission_request_card.dart';
import '../widgets/mission_request_form.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

  void _showRequestForm(BuildContext context) {
    showAppBottomSheet(
      context: context,
      title: 'Request Mission'.tr(),
      body: MissionRequestForm(
        onSubmit: (startDate, endDate, days, reason) {
          context.read<MissionCubit>().addMissionRequest(
            startDate,
            endDate,
            days,
            reason,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MissionCubit()..loadRequests(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Mission Requests'.tr()),
        body: BlocBuilder<MissionCubit, MissionState>(
          builder: (context, state) {
            if (state is MissionLoading) {
              return const Center(child: LoaderWidget());
            }

            if (state is MissionEmpty) {
              return EmptyScreen(
                title: 'No Mission Requests'.tr(),
                description: "You haven't submitted any mission requests yet."
                    .tr(),
                buttonText: 'Request Mission'.tr(),
                image: AppAssets.appLogo,

                onTap: () => _showRequestForm(context),
              );
            }

            if (state is MissionLoaded) {
              return RefreshIndicator(
                onRefresh: () => context.read<MissionCubit>().loadRequests(),
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
                      child: MissionRequestCard(request: state.requests[index]),
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
        floatingActionButton: BlocBuilder<MissionCubit, MissionState>(
          builder: (context, state) {
            if (state is MissionLoaded) {
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
