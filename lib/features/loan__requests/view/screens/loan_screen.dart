import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/app_validation.dart';
import 'package:hr_manegement/core/di/di.dart';

import 'package:hr_manegement/features/loan__requests/controller/loan_cubit.dart';
import 'package:hr_manegement/features/loan__requests/controller/loan_state.dart';
import 'package:hr_manegement/features/loan__requests/data/models/loan_request.dart';

import '../../../../ sheard/componnents/app_asset_image.dart';
import '../../../../ sheard/componnents/app_shimmers.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/screen_builder/screen_builder.dart';
import '../../../../ sheard/componnents/show_app_toast.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import '../widgets/loan_request_card.dart';
import '../widgets/loan_request_form.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoanCubit>()..getAllLoans(),
      child: const _LoanView(),
    );
  }
}

class _LoanView extends StatefulWidget {
  const _LoanView();

  @override
  State<_LoanView> createState() => _LoanViewState();
}

class _LoanViewState extends State<_LoanView> {
  final searchController = TextEditingController();
  final scrollController = ScrollController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        context.read<LoanCubit>().getAllLoans(loadMore: true);
      }
    });
  }

  void _showRequestForm() {
    final cubit = context.read<LoanCubit>();

    showAppBottomSheet(
      context: context,
      title: 'Request Loan'.tr(),
      body: BlocProvider.value(
        value: cubit,
        child: LoanRequestForm(
          onSubmit: (date, amount, loanType, notes) {
            cubit.createLoans(
              model: LoanRequest(
                requestDate: date.toString().split(" ").first,
                amount: amount,
                loanType: loanType,
                notes: notes,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoanCubit, LoanState>(
      listenWhen: (prev, current) =>
          current is DeleteLoanSuccess ||
          current is DeleteLoanError ||
          current is UpdateLoanSuccess ||
          current is UpdateLoanError,
      listener: (context, state) {
        if (state is DeleteLoanSuccess) {
          CustomToast.show(message: "delete_success".tr());
        }
        if (state is UpdateLoanSuccess) {
          CustomToast.show(message: "update_success".tr());
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: 'Loan Requests'.tr()),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CustomTextField(
                hint: 'search_by_name'.tr(),
                type: TextInputType.text,
                controller: searchController,
                prefix: const AppAssetImage(
                  uri: AppAssets.search,
                  color: AppColors.primary,
                  fit: BoxFit.scaleDown,
                  width: 23,
                  height: 23,
                ),
                onChange: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {});
                },
                validator: Validations.noValidation,
              ),
              AppSizedBox.h2,
              Expanded(
                child: BlocBuilder<LoanCubit, LoanState>(
                  buildWhen: (previous, current) =>
                      current is GetAllLoansLoading ||
                      current is GetAllLoansLoaded ||
                      current is GetAllLoansError ||
                      current is PaginationLoading,
                  builder: (context, state) {
                    var cubit = LoanCubit.get(context);
                    return RefreshIndicator(
                      onRefresh: () => cubit.getAllLoans(),
                      child: CustomApiBuilderView(
                        isLoading: state is GetAllLoansLoading,
                        isError: state is GetAllLoansError,
                        isEmpty: cubit.loans.isEmpty,
                        contentBuilder: () => Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: cubit.loans.length,
                                itemBuilder: (context, index) {
                                  return LoanRequestCard(
                                    request: cubit.loans[index],
                                  );
                                },
                              ),
                            ),
                            AppSizedBox.h1,
                            if (state is PaginationLoading)
                              const Center(child: LoaderWidget()),
                          ],
                        ),
                        loadingWidget: AppShimmer.verticalList(),
                        onRetry: () => cubit.getAllLoans(),
                        errorMessage: state is GetAllLoansError
                            ? state.error
                            : null,
                        emptyTitle: "no_loans".tr(),
                        emptyDescription: "no_data".tr(),
                        onEmpty: _showRequestForm,
                        onEmptyButtonText: "add_loan".tr(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<LoanCubit, LoanState>(
          builder: (context, state) {
            final cubit = context.read<LoanCubit>();
            if (cubit.loans.isEmpty) {
              return const SizedBox();
            }
            return FloatingActionButton(
              onPressed: _showRequestForm,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
