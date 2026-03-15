import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/features/componnents/empty_screen.dart';

import '../../controller/holiday_cubit.dart';
import '../../controller/holiday_state.dart';
import '../widgets/holiday_empty_state.dart';
import '../widgets/holiday_request_card.dart';
import '../widgets/holiday_request_form.dart';

class HolidayScreen extends StatelessWidget {
  const HolidayScreen({super.key});

  void _showRequestForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backGround,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (sheetContext) {
        return BlocProvider.value(
          value: context.read<HolidayCubit>(),
          child: HolidayRequestForm(
            onSubmit: (startDate, endDate, reason) {
              context
                  .read<HolidayCubit>()
                  .addHolidayRequest(startDate, endDate, reason);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HolidayCubit()..loadRequests(),
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        appBar: AppBar(
          backgroundColor: AppColors.backGround,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textMain,
              size: 5.w,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'holiday_requests'.tr(),
            style: AppTextStyle.subHeadline.copyWith(
              color: AppColors.textMain,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<HolidayCubit, HolidayState>(
          builder: (context, state) {
            if (state is HolidayLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HolidayEmpty) {
              return
                EmptyScreen(
                  title: 'no_requests'.tr(),
                  description: 'no_requests_subtitle'.tr(),
                  buttonText: 'request_holiday'.tr(),
                  image: 'assets/images/logo.png',

                  onTap:()=>_showRequestForm(context));
              //   HolidayEmptyState(
              //   onRequestHoliday: () => _showRequestForm(context),
              // );
            };

            if (state is HolidayLoaded) {
              return RefreshIndicator(
                onRefresh: () =>
                    context.read<HolidayCubit>().loadRequests(),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 2.h,
                  ),
                  itemCount: state.requests.length,
                  itemBuilder: (context, index) {
                    return TweenAnimationBuilder<double>(
                      duration:
                      Duration(milliseconds: 300 + (index * 100)),
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
        floatingActionButton:
        BlocBuilder<HolidayCubit, HolidayState>(
          builder: (context, state) {
            if (state is HolidayLoaded) {
              return FloatingActionButton(
                onPressed: () => _showRequestForm(context),
                backgroundColor: AppColors.primary,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}