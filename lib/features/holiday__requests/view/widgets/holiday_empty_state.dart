import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:hr_manegement/features/componnents/custom_button.dart';

class HolidayEmptyState extends StatelessWidget {
  final VoidCallback onRequestHoliday;

  const HolidayEmptyState({
    super.key,
    required this.onRequestHoliday,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.beach_access_rounded,
                color: AppColors.primary,
                size: 20.w,
              ),
            ),
            AppSizedBox.h4,
            Text(
              'no_requests'.tr(),
              style: AppTextStyle.subHeadline.copyWith(
                color: AppColors.textMain,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            AppSizedBox.h1,
            Text(
              'no_requests_subtitle'.tr(), // "You haven't submitted any requests yet"
              style: AppTextStyle.body.copyWith(
                color: AppColors.textSub,
              ),
              textAlign: TextAlign.center,
            ),
            AppSizedBox.h4,
            CustomButton(
              text: 'request_holiday'.tr(),
              onTap: onRequestHoliday,
              width: double.infinity,
              radius: 12,
              txtcolor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
