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

import '../../controller/holiday_cubit.dart';
import '../../controller/holiday_state.dart';
import '../widgets/holiday_request_card.dart';
import '../widgets/holiday_request_form.dart';

class HolidayScreen extends StatelessWidget {
  const HolidayScreen({super.key});

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
        body: BlocBuilder<HolidayCubit, HolidayState>(
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
                onRefresh: () => context.read<HolidayCubit>().loadRequests(),
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
                      child: HolidayRequestCard(request: state.requests[index]),
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
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
