import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../ sheard/componnents/show_app_toast.dart';
import '../../../../ sheard/componnents/show_flutter_snackbar.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_sized_box.dart';
import '../../../../core/app_validation.dart';

import '../../../../ sheard/componnents/app_asset_image.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/empty_screen.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';

import '../../controller/business_trip_cubit.dart';
import '../../controller/business_trip_state.dart';
import '../../data/models/business_trip_request.dart';
import '../widgets/business_trip_request_card.dart';
import '../widgets/business_trip_request_form.dart';

import '../../../../core/di/di.dart';

class BusinessTripScreen extends StatelessWidget {
  const BusinessTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BusinessTripCubit>()..getAllTrips(),
      child: const _BusinessTripView(),
    );
  }
}

class _BusinessTripView extends StatefulWidget {
  const _BusinessTripView();

  @override
  State<_BusinessTripView> createState() => _BusinessTripViewState();
}

class _BusinessTripViewState extends State<_BusinessTripView> {
  final searchController = TextEditingController();
  Timer? _debounce;

  void _showRequestForm() {
    final cubit = context.read<BusinessTripCubit>();

    showAppBottomSheet(
      context: context,
      title: 'Request Business Trip'.tr(),
      body: BlocProvider.value(
        value: cubit,
        child: BusinessTripRequestForm(
          onSubmit: (startDate, endDate, days, reason) {
            cubit.createTrip(
              model: BusinessTripRequest(
                tripType: "business",
                fromDate: startDate.toString().split(" ").first,
                toDate: startDate.toString().split(" ").first,
                daysCount: days,
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
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BusinessTripCubit, BusinessTripState>(
      listenWhen: (prev, current) =>
      current is DeleteTripSuccess || current is DeleteTripError,
      listener: (context, state) {
        if (state is DeleteTripSuccess) {
          showFlutterSnackBar(
            message: state.error ?? "تم الحذف بنجاح",
            toastColor: AppColors.red,
          );
        }


        },
      child: Scaffold(
        appBar: CustomAppBar(title: 'Business Trip Requests'.tr()),
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
                ),
                onChange: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce =
                      Timer(const Duration(milliseconds: 500), () {});
                },
                validator: Validations.noValidation,
              ),

              AppSizedBox.h2,

              Expanded(
                child: BlocBuilder<BusinessTripCubit, BusinessTripState>(
                  builder: (context, state) {
                    final cubit = context.read<BusinessTripCubit>();

                    if (state is GetAllTripsLoading) {
                      return const Center(child: LoaderWidget());
                    }

                    if (cubit.trips.isEmpty) {
                      return EmptyScreen(
                        title: 'no_business_trips'.tr(),
                        description: 'no_data'.tr(),
                        buttonText: 'add_business_trip'.tr(),
                        image: AppAssets.appLogo,
                        onTap: _showRequestForm,
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => cubit.getAllTrips(),
                      child: ListView.builder(
                        itemCount: cubit.trips.length,
                        itemBuilder: (context, index) {
                          return BusinessTripRequestCard(
                            trip: cubit.trips[index],
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

        floatingActionButton: BlocBuilder<BusinessTripCubit, BusinessTripState>(
          builder: (context, state) {
            final cubit = context.read<BusinessTripCubit>();

            if (cubit.trips.isEmpty) {
              return const SizedBox(); // 👈 يخفيه
            }

            return FloatingActionButton(
              onPressed: _showRequestForm,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add),
            );
          },
        ),      ),
    );
  }
}