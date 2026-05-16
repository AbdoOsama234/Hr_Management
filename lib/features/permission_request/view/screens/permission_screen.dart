import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/di/di.dart';

import '../../../../ sheard/componnents/app_asset_image.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/empty_screen.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import '../../../../core/app_sized_box.dart';
import '../../../../core/app_validation.dart';

import '../../controller/permission_cubit.dart';
import '../../controller/permission_state.dart';
import '../widgets/permission_request_card.dart';
import '../widgets/permission_request_form.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  void _showRequestForm(BuildContext context) {
    showAppBottomSheet(
      context: context,
      title: 'Request Permission'.tr(),
      body: PermissionRequestForm(
        onSubmit: (model) {
          context.read<PermissionCubit>().createPermission(model: model);
        },
      ),
    );
  }

  var searchController = TextEditingController();
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PermissionCubit>()..getAllPermissions(),
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
                    print("Search value is $value");
                  });
                },
                validator: Validations.noValidation,
              ),
              AppSizedBox.h2,

              Expanded(
                child: BlocBuilder<PermissionCubit, PermissionState>(
                  builder: (context, state) {
                    final cubit = context.read<PermissionCubit>();

                    if (state is GetAllPermissionsLoading) {
                      return const Center(child: LoaderWidget());
                    }

                    if (cubit.permissions.isEmpty &&
                        state is GetAllPermissionsLoaded) {
                      return EmptyScreen(
                        title: 'No Permission Requests'.tr(),
                        description:
                            "You haven't submitted any permission requests yet."
                                .tr(),
                        buttonText: 'Request Permission'.tr(),
                        image: AppAssets.appLogo,

                        onTap: () => _showRequestForm(context),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => cubit.getAllPermissions(),
                      child: ListView.builder(
                        itemCount:
                            cubit.permissions.length +
                            (state is PaginationLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < cubit.permissions.length) {
                            final request = cubit.permissions[index];
                            return TweenAnimationBuilder<double>(
                              duration: Duration(
                                milliseconds: 300 + (index * 100),
                              ),
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
                              child: PermissionRequestCard(request: request),
                            );
                          } else {
                            return const Center(child: LoaderWidget());
                          }
                        },
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
            return FloatingActionButton(
              onPressed: () => _showRequestForm(context),
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
