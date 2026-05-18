import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../ sheard/componnents/app_asset_image.dart';
import '../../../../ sheard/componnents/app_shimmers.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/screen_builder/screen_builder.dart';
import '../../../../ sheard/componnents/show_app_toast.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_sized_box.dart';
import '../../../../core/app_validation.dart';
import '../../../../core/di/di.dart';

import '../../controller/errand_cubit.dart';
import '../../controller/errand_state.dart';

import '../../data/models/errand_request.dart';

import '../widgets/errand_request_card.dart';
import '../widgets/errand_request_form.dart';

class ErrandScreen extends StatelessWidget {
  const ErrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ErrandCubit>()..getAllErrands(),
      child: const _ErrandView(),
    );
  }
}

class _ErrandView extends StatefulWidget {
  const _ErrandView();

  @override
  State<_ErrandView> createState() => _ErrandViewState();
}

class _ErrandViewState extends State<_ErrandView> {
  final searchController = TextEditingController();
  final scrollController = ScrollController();

  Timer? _debounce;

  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        context.read<ErrandCubit>().getAllErrands(loadMore: true);
      }
    });
  }

  void _showRequestForm() {
    final cubit = context.read<ErrandCubit>();

    showAppBottomSheet(
      context: context,
      title: 'Request Errand'.tr(),
      body: BlocProvider.value(
        value: cubit,
        child: ErrandRequestForm(
          onSubmit: (startDate, endDate, days, reason) {
            cubit.createErrands(
              model: ErrandRequest(
                fromDate: startDate.toString().split(" ").first,
                toDate: endDate.toString().split(" ").first,
                daysCount: days,
                requestNotes: reason,
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
    return BlocListener<ErrandCubit, ErrandState>(
      listenWhen: (prev, current) =>
          current is DeleteErrandSuccess ||
          current is DeleteErrandError ||
          current is UpdateErrandSuccess ||
          current is UpdateErrandError,

      listener: (context, state) {
        if (state is DeleteErrandSuccess) {
          CustomToast.show(message: "delete_success".tr());
        }

        if (state is UpdateErrandSuccess) {
          CustomToast.show(message: "update_success".tr());
        }
      },

      child: Scaffold(
        appBar: CustomAppBar(title: 'Errand Requests'.tr()),

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
                  if (_debounce?.isActive ?? false) {
                    _debounce!.cancel();
                  }

                  _debounce = Timer(const Duration(milliseconds: 500), () {});
                },

                validator: Validations.noValidation,
              ),

              AppSizedBox.h2,

              Expanded(
                child: BlocBuilder<ErrandCubit, ErrandState>(
                  buildWhen: (previous, current) =>
                      current is GetAllErrandsLoading ||
                      current is GetAllErrandsLoaded ||
                      current is GetAllErrandsError ||
                      current is PaginationLoading,

                  builder: (context, state) {
                    final cubit = ErrandCubit.get(context);

                    return RefreshIndicator(
                      onRefresh: () => cubit.getAllErrands(),

                      child: CustomApiBuilderView(
                        isLoading: state is GetAllErrandsLoading,

                        isError: state is GetAllErrandsError,

                        isEmpty: cubit.errands.isEmpty,

                        contentBuilder: () => Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: cubit.errands.length,

                                itemBuilder: (context, index) {
                                  return ErrandRequestCard(
                                    request: cubit.errands[index],
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

                        onRetry: () => cubit.getAllErrands(),

                        errorMessage: state is GetAllErrandsError
                            ? state.error
                            : null,

                        emptyTitle: "no_errands".tr(),

                        emptyDescription: "no_data".tr(),

                        onEmpty: _showRequestForm,

                        onEmptyButtonText: "add_errand".tr(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: BlocBuilder<ErrandCubit, ErrandState>(
          builder: (context, state) {
            final cubit = context.read<ErrandCubit>();

            if (cubit.errands.isEmpty) {
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
