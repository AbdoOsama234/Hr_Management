import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/%20sheard/componnents/app_asset_image.dart';
import 'package:hr_manegement/%20sheard/componnents/app_shimmers.dart';
import 'package:hr_manegement/%20sheard/componnents/custom_app_bar.dart';
import 'package:hr_manegement/%20sheard/componnents/custom_text_field.dart';
import 'package:hr_manegement/%20sheard/componnents/loading_widget.dart';
import 'package:hr_manegement/%20sheard/componnents/screen_builder/screen_builder.dart';
import 'package:hr_manegement/%20sheard/componnents/show_app_toast.dart';
import 'package:hr_manegement/%20sheard/componnents/show_bottom_sheet.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_sized_box.dart';
import '../../../../core/app_validation.dart';

import '../../../../core/di/di.dart';

import '../../controller/permission_cubit.dart';
import '../../controller/permission_state.dart';

import '../widgets/permission_request_card.dart';
import '../widgets/permission_request_form.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PermissionCubit>()..getAllPermissions(),
      child: const _PermissionScreenView(),
    );
  }
}

class _PermissionScreenView extends StatefulWidget {
  const _PermissionScreenView();

  @override
  State<_PermissionScreenView> createState() => _PermissionScreenViewState();
}

class _PermissionScreenViewState extends State<_PermissionScreenView> {
  final searchController = TextEditingController();
  final scrollController = ScrollController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        context.read<PermissionCubit>().getAllPermissions(loadMore: true);
      }
      context.read<PermissionCubit>().getAllPermissions(loadMore: true);
    });
  }

  void _showRequestForm() {
    final cubit = context.read<PermissionCubit>();

    showAppBottomSheet(
      context: context,
      title: 'Request Permission'.tr(),
      body: BlocProvider.value(
        value: cubit,
        child: PermissionRequestForm(
          onSubmit: (model) {
            cubit.createPermission(model: model);
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
    return BlocListener<PermissionCubit, PermissionState>(
      listenWhen: (prev, current) =>
          current is CreatePermissionSuccess ||
          current is CreatePermissionError ||
          current is DeletePermissionSuccess ||
          current is DeletePermissionError ||
          current is UpdatePermissionSuccess ||
          current is UpdatePermissionError,
      listener: (context, state) {
        if (state is CreatePermissionSuccess) {
          CustomToast.show(message: state.message ?? "create_success".tr());
        }

        if (state is DeletePermissionSuccess) {
          CustomToast.show(message: state.message ?? "delete_success".tr());
        }

        if (state is UpdatePermissionSuccess) {
          CustomToast.show(message: state.message ?? "update_success".tr());
        }

        if (state is CreatePermissionError) {
          CustomToast.show(message: state.error ?? "something_went_wrong".tr());
        }

        if (state is DeletePermissionError) {
          CustomToast.show(message: state.error ?? "something_went_wrong".tr());
        }

        if (state is UpdatePermissionError) {
          CustomToast.show(message: state.error ?? "something_went_wrong".tr());
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: 'Permission Requests'.tr()),
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

                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    // Search Logic
                  });
                },
                validator: Validations.noValidation,
              ),

              AppSizedBox.h2,

              Expanded(
                child: BlocBuilder<PermissionCubit, PermissionState>(
                  buildWhen: (previous, current) =>
                      current is GetAllPermissionsLoading ||
                      current is GetAllPermissionsLoaded ||
                      current is GetAllPermissionsError ||
                      current is PaginationLoading,
                  builder: (context, state) {
                    final cubit = PermissionCubit.get(context);

                    return RefreshIndicator(
                      onRefresh: cubit.getAllPermissions,
                      child: CustomApiBuilderView(
                        isLoading: state is GetAllPermissionsLoading,
                        isError: state is GetAllPermissionsError,
                        isEmpty: cubit.permissions.isEmpty,
                        contentBuilder: () => Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: cubit.permissions.length,
                                itemBuilder: (context, index) {
                                  return PermissionRequestCard(
                                    request: cubit.permissions[index],
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
                        onRetry: cubit.getAllPermissions,
                        errorMessage: state is GetAllPermissionsError
                            ? state.error
                            : null,
                        emptyTitle: "no_permission_requests".tr(),
                        emptyDescription: "no_data".tr(),
                        onEmpty: _showRequestForm,
                        onEmptyButtonText: "request_permission".tr(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: BlocBuilder<PermissionCubit, PermissionState>(
          builder: (context, state) {
            final cubit = context.read<PermissionCubit>();

            if (cubit.permissions.isEmpty) {
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
