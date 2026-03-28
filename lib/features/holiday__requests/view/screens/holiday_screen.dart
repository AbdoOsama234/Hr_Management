import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';


import '../../../../ sheard/componnents/app_asset_image.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/empty_screen.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import '../../../../core/app_sized_box.dart' show AppSizedBox;
import '../../../../core/app_validation.dart';

import '../../controller/holiday_cubit.dart';
import '../../controller/holiday_state.dart';
import '../widgets/holiday_request_card.dart';
import '../widgets/holiday_request_form.dart';

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key});

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  var searchController = TextEditingController();
  Timer? _debounce;
  void _showRequestForm(BuildContext context) {
    showAppBottomSheet(
      context: context,
      title: 'request_holiday'.tr(),
      body: HolidayRequestForm(
        onSubmit: (startDate, endDate, reason) {
          context.read<HolidayCubit>().addHolidayRequest(
            startDate,
            endDate,
            reason,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HolidayCubit()..loadRequests(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'holiday_requests'.tr()),
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
                child: BlocBuilder<HolidayCubit, HolidayState>(
                  builder: (context, state) {
                    if (state is HolidayLoading) {
                      return const Center(child: LoaderWidget());
                    }

                    if (state is HolidayEmpty) {
                      return EmptyScreen(
                        title: 'no_requests'.tr(),
                        description: 'no_requests_subtitle'.tr(),
                        buttonText: 'request_holiday'.tr(),
                        image: AppAssets.appLogo,

                        onTap: () => _showRequestForm(context),
                      );
                    }

                    if (state is HolidayLoaded) {
                      return RefreshIndicator(
                        onRefresh: () =>
                            context.read<HolidayCubit>().loadRequests(),
                        child: ListView.builder(
                          itemCount: state.requests.length,
                          itemBuilder: (context, index) {
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
                              child: HolidayRequestCard(
                                request: state.requests[index],
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<HolidayCubit, HolidayState>(
          builder: (context, state) {
            if (state is HolidayLoaded) {
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
