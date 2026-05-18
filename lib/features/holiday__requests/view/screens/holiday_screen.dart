import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/extensions.dart';

import '../../../../ sheard/componnents/app_shimmers.dart';
import '../../../../ sheard/componnents/screen_builder/screen_builder.dart';
import '../../../../ sheard/componnents/show_app_toast.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_sized_box.dart';
import '../../../../core/app_validation.dart';

import '../../../../ sheard/componnents/app_asset_image.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';

import '../../controller/holiday_cubit.dart';
import '../../controller/holiday_state.dart';
import '../../data/models/holiday_request.dart';
import '../widgets/holiday_request_card.dart';
import '../widgets/holiday_request_form.dart';

import '../../../../core/di/di.dart';

class HolidayScreen extends StatelessWidget {
  const HolidayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HolidayCubit>()..getAllHolidays(),
      child: const _HolidayView(),
    );
  }
}

class _HolidayView extends StatefulWidget {
  const _HolidayView();

  @override
  State<_HolidayView> createState() => _HolidayViewState();
}

class _HolidayViewState extends State<_HolidayView> {
  final searchController = TextEditingController();
  final scrollController = ScrollController();

  Timer? _debounce;

  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        context.read<HolidayCubit>().getAllHolidays(loadMore: true);
      }
    });
  }

  void _showRequestForm() {
    final cubit = context.read<HolidayCubit>();

    showAppBottomSheet(
      context: context,
      title: 'Request Holiday'.tr(),
      body: BlocProvider.value(
        value: cubit,
        child: HolidayRequestForm(
          onSubmit: (startDate, endDate, days, reason) {
            cubit.createHoliday(
              model: HolidayRequest(
                type: "holiday",
                fromDate: startDate.toString().split(" ").first,
                toDate: endDate.toString().split(" ").first,
                days: days.toString(),
                requestNotes: reason,
                statusNotes: "",
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
    return BlocListener<HolidayCubit, HolidayState>(
      listenWhen: (prev, current) =>
          current is CreateHolidaySuccess ||
          current is CreateHolidayError ||
          current is DeleteHolidaySuccess ||
          current is DeleteHolidayError ||
          current is UpdateHolidaySuccess ||
          current is UpdateHolidayError,

      listener: (context, state) {
        if (state is CreateHolidaySuccess) {
          CustomToast.show(message: "create_success".tr());
        }
        if (state is CreateHolidayError) {
          CustomToast.show(
            message: state.error.orEmpty(),
            type: ToastType.error,
          );
        }
        if (state is DeleteHolidaySuccess) {
          CustomToast.show(message: state.error ?? "delete_success".tr());
        }
        if (state is UpdateHolidaySuccess) {
          CustomToast.show(message: state.error ?? "update_success".tr());
        }
      },

      child: Scaffold(
        appBar: CustomAppBar(title: 'Holiday Requests'.tr()),
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
                child: BlocBuilder<HolidayCubit, HolidayState>(
                  buildWhen: (previous, current) =>
                      current is GetAllHolidaysLoading ||
                      current is GetAllHolidaysLoaded ||
                      current is GetAllHolidaysError ||
                      current is PaginationLoading,
                  builder: (context, state) {
                    var cubit = HolidayCubit.get(context);
                    return RefreshIndicator(
                      onRefresh: () => cubit.getAllHolidays(),
                      child: CustomApiBuilderView(
                        isLoading: state is GetAllHolidaysLoading,
                        isError: state is GetAllHolidaysError,
                        isEmpty: cubit.holidays.isEmpty,
                        contentBuilder: () => Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: cubit.holidays.length,
                                itemBuilder: (context, index) {
                                  return HolidayRequestCard(
                                    holiday: cubit.holidays[index],
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
                        onRetry: () => cubit.getAllHolidays(),
                        errorMessage: state is GetAllHolidaysError
                            ? state.error
                            : null,
                        emptyTitle: "no_holiday_requests".tr(),
                        emptyDescription: "no_data".tr(),
                        onEmpty: _showRequestForm,
                        onEmptyButtonText: "add_holiday_request".tr(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: BlocBuilder<HolidayCubit, HolidayState>(
          builder: (context, state) {
            final cubit = context.read<HolidayCubit>();

            if (cubit.holidays.isEmpty) {
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
