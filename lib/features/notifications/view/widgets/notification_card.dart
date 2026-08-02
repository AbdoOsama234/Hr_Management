import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

class NotificationCard extends StatelessWidget {
  final NotificationData notification;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss?.call(),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsetsDirectional.only(end: 20),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.delete_outline_rounded,
          color: AppColors.primary,
          size: 26,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: AppColors.backGround2,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: notification.isRead
                  ? Colors.transparent
                  : AppColors.primary.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Icon container ──
                _buildIconContainer(),
                SizedBox(width: 3.w),

                // ── Content ──
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row with unread dot
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.title.copyWith(
                                fontSize: 13.sp,
                                fontWeight: notification.isRead
                                    ? FontWeight.w500
                                    : FontWeight.bold,
                              ),
                            ),
                          ),
                          if (!notification.isRead) ...[
                            SizedBox(width: 2.w),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      AppSizedBox.h05,

                      // Body text
                      Text(
                        notification.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.smallBody.copyWith(
                          fontSize: 11.sp,
                          color: AppColors.textSub.withValues(alpha: 0.8),
                          height: 1.4,
                        ),
                      ),
                      AppSizedBox.h07,

                      // Date
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 13,
                            color: AppColors.textSub.withValues(alpha: 0.5),
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            notification.date,
                            style: AppTextStyle.hint.copyWith(
                              fontSize: 9.sp,
                              color: AppColors.textSub.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: _getIconColor().withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(_getIcon(), color: _getIconColor(), size: 22),
    );
  }

  IconData _getIcon() {
    switch (notification.type) {
      case NotificationType.holiday:
        return Icons.event_note_rounded;
      case NotificationType.idea:
        return Icons.lightbulb_outline_rounded;
      case NotificationType.errand:
        return Icons.work_outline_rounded;
      case NotificationType.announcement:
        return Icons.campaign_rounded;
      case NotificationType.general:
        return Icons.notifications_rounded;
    }
  }

  Color _getIconColor() {
    switch (notification.type) {
      case NotificationType.holiday:
        return AppColors.mintGreen;
      case NotificationType.idea:
        return AppColors.orange;
      case NotificationType.errand:
        return AppColors.blue;
      case NotificationType.announcement:
        return AppColors.primary;
      case NotificationType.general:
        return AppColors.textSub;
    }
  }
}

// ─────────────────────────────────────────────
// Data Models
// ─────────────────────────────────────────────

enum NotificationType { holiday, idea, errand, announcement, general }

class NotificationData {
  final String title;
  final String body;
  final String date;
  final NotificationType type;
  final bool isRead;

  const NotificationData({
    required this.title,
    required this.body,
    required this.date,
    required this.type,
    this.isRead = false,
  });

  NotificationData copyWith({
    String? title,
    String? body,
    String? date,
    NotificationType? type,
    bool? isRead,
  }) {
    return NotificationData(
      title: title ?? this.title,
      body: body ?? this.body,
      date: date ?? this.date,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }
}
