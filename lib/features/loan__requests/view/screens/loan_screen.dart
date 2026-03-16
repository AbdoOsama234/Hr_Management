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

import '../../controller/loan_cubit.dart';
import '../../controller/loan_state.dart';
import '../widgets/loan_request_card.dart';
import '../widgets/loan_request_form.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({super.key});

  void _showRequestForm(BuildContext context) {
    showAppBottomSheet(
      context: context,
      title: 'Request Loan'.tr(),
      body: LoanRequestForm(
        onSubmit: (date, loan, reason) {
          context.read<LoanCubit>().addLoanRequest(date, loan, reason);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoanCubit()..loadRequests(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Loan Requests'.tr()),
        body: BlocBuilder<LoanCubit, LoanState>(
          builder: (context, state) {
            if (state is LoanLoading) {
              return const Center(child: LoaderWidget());
            }

            if (state is LoanEmpty) {
              return EmptyScreen(
                title: 'No Loan Requests'.tr(),
                description: "You haven't submitted any loan requests yet."
                    .tr(),
                buttonText: 'Request Loan'.tr(),
                image: AppAssets.appLogo,

                onTap: () => _showRequestForm(context),
              );
            }

            if (state is LoanLoaded) {
              return RefreshIndicator(
                onRefresh: () => context.read<LoanCubit>().loadRequests(),
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
                      child: LoanRequestCard(request: state.requests[index]),
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
        floatingActionButton: BlocBuilder<LoanCubit, LoanState>(
          builder: (context, state) {
            if (state is LoanLoaded) {
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
