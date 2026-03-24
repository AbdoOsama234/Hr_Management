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

import '../../controller/errand_cubit.dart';
import '../../controller/errand_state.dart';
import '../widgets/errand_request_card.dart';
import '../widgets/errand_request_form.dart';

class ErrandScreen extends StatelessWidget {
  const ErrandScreen({super.key});

  void _showRequestForm(BuildContext context) {
    showAppBottomSheet(
      context: context,
      title: 'Request Errand'.tr(),
      body: ErrandRequestForm(
        onSubmit: (startDate, endDate, days, reason) {
          context.read<ErrandCubit>().addErrandRequest(
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
      create: (context) => ErrandCubit()..loadRequests(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Errand Requests'.tr()),
        body: BlocBuilder<ErrandCubit, ErrandState>(
          builder: (context, state) {
            if (state is ErrandLoading) {
              return const Center(child: LoaderWidget());
            }

            if (state is ErrandEmpty) {
              return EmptyScreen(
                title: 'No Errand Requests'.tr(),
                description: "You haven't submitted any errand requests yet."
                    .tr(),
                buttonText: 'Request Errand'.tr(),
                image: AppAssets.appLogo,

                onTap: () => _showRequestForm(context),
              );
            }

            if (state is ErrandLoaded) {
              return RefreshIndicator(
                onRefresh: () => context.read<ErrandCubit>().loadRequests(),
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
                      child: ErrandRequestCard(request: state.requests[index]),
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
        floatingActionButton: BlocBuilder<ErrandCubit, ErrandState>(
          builder: (context, state) {
            if (state is ErrandLoaded) {
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

