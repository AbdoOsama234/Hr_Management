import 'package:flutter/material.dart';
import 'package:hr_manegement/features/componnents/icon_button.dart'
    show AppIcon, AppMainIconButton;

import '../../../../core/app_assets.dart';
import '../../../../core/app_colors.dart';
import '../../core/text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.isNotificationScreen = false,
    this.onTap,
  });
  final String title;
  final bool isNotificationScreen;
  final List<Widget>? actions;
  final dynamic Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTextStyle.title),
      backgroundColor: AppColors.backGround,
      leadingWidth: 60,
      leading: Padding(
        padding: const EdgeInsetsDirectional.all(8),
        child: AppIcon(
          onTap: () {
            if (onTap != null) {
              onTap!();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      actions: [
        ...(actions ?? []),
        // if (!isNotificationScreen) const NotificationIcon(),
        // AppSizedBox.w2
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainIconButton(
      icon: AppAssets.notification,
      iconSize: 25,
      iconColor: AppColors.white,
      onTap: () {
        //Navigator.pushNamed(context, Routes.notification1);
      },
    );
  }
}
