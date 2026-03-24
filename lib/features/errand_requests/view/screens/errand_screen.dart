import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/features/componnents/custom_app_bar.dart';
import 'package:hr_manegement/features/componnents/empty_screen.dart';
import 'package:hr_manegement/features/componnents/loading_widget.dart';
import 'package:hr_manegement/features/componnents/show_bottom_sheet.dart';

import '../../../../core/app_sized_box.dart';
import '../../../../core/app_validation.dart';
import '../../../componnents/app_asset_image.dart';
import '../../../componnents/custom_text_field.dart';
import '../../controller/errand_cubit.dart';
import '../../controller/errand_state.dart';
import '../widgets/errand_request_card.dart';
import '../widgets/errand_request_form.dart';

class ErrandScreen extends StatefulWidget {
  const ErrandScreen({super.key});

  @override
  State<ErrandScreen> createState() => _ErrandScreenState();
}

class _ErrandScreenState extends State<ErrandScreen> {
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

  var searchController = TextEditingController();
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ErrandCubit()..loadRequests(),
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
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    print("Search value is $value");
                  });
                },
                validator: Validations.noValidation,
              ),
              AppSizedBox.h2,
              Expanded(
                child: BlocBuilder<ErrandCubit, ErrandState>(
                  builder: (context, state) {
                    if (state is ErrandLoading) {
                      return const Center(child: LoaderWidget());
                    }

                    if (state is ErrandEmpty) {
                      return EmptyScreen(
                        title: 'No Errand Requests'.tr(),
                        description:
                            "You haven't submitted any errand requests yet."
                                .tr(),
                        buttonText: 'Request Errand'.tr(),
                        image: AppAssets.appLogo,

                        onTap: () => _showRequestForm(context),
                      );
                    }

                    if (state is ErrandLoaded) {
                      return RefreshIndicator(
                        onRefresh: () =>
                            context.read<ErrandCubit>().loadRequests(),
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
                              child: ErrandRequestCard(
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
