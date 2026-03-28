import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';

import '../../../../ sheard/componnents/app_asset_image.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/app_colors.dart' show AppColors;
import '../../../../core/app_validation.dart';

import '../widgets/notification_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var searchController = TextEditingController();
  Timer? _debounce;

  final List<NotificationData> notifications = [
    NotificationData(
      title: 'notification_holiday_approved_title'.tr(),
      body: 'notification_holiday_approved_body'.tr(),
      date: 'time_2_min_ago'.tr(),
      type: NotificationType.holiday,
      isRead: false,
    ),
    NotificationData(
      title: 'notification_new_idea_title'.tr(),
      body: 'notification_new_idea_body'.tr(),
      date: 'time_1_hour_ago'.tr(),
      type: NotificationType.idea,
      isRead: false,
    ),
    NotificationData(
      title: 'notification_errand_pending_title'.tr(),
      body: 'notification_errand_pending_body'.tr(),
      date: 'time_3_hours_ago'.tr(),
      type: NotificationType.errand,
      isRead: true,
    ),
    NotificationData(
      title: 'notification_announcement_title'.tr(),
      body: 'notification_announcement_body'.tr(),
      date: 'time_yesterday'.tr(),
      type: NotificationType.announcement,
      isRead: true,
    ),
    NotificationData(
      title: 'notification_welcome_title'.tr(),
      body: 'notification_welcome_body'.tr(),
      date: 'time_2_days_ago'.tr(),
      type: NotificationType.general,
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'notifications'.tr()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => AppSizedBox.h1,
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              itemBuilder: (context, index) {
                return NotificationCard(
                  notification: notifications[index],
                  onTap: () {
                    setState(() {
                      notifications[index] = notifications[index].copyWith(
                        isRead: true,
                      );
                    });
                  },
                  onDismiss: () {
                    setState(() {
                      notifications.removeAt(index);
                    });
                  },
                );
              },
            ),
            AppSizedBox.h4,
          ],
        ),
      ),
    );
  }
}
