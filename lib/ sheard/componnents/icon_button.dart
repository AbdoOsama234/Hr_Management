import 'dart:ui';

import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/constants.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/data/storage/local/app_prefs.dart';
import 'package:flutter/material.dart';

import 'app_asset_image.dart';

class AppMainIconButton extends StatelessWidget {
  const AppMainIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.borderColor,
    this.iconColor,
    this.backGroundColor,
    this.iconSize = 25,
    this.padding = 5,
    this.radius = Constants.defaultRadius,
    this.isCirclar,
    this.titleColor,
    this.fit,
    this.titleIcon,
  });
  final String icon;
  final Function()? onTap;
  final Color? iconColor;
  final Color? backGroundColor;
  final double iconSize;
  final double padding;
  final double radius;
  final Color? borderColor;
  final bool? isCirclar;
  final BoxFit? fit;
  final String? titleIcon;
  final Color? titleColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: backGroundColor,
              borderRadius: (isCirclar ?? false)
                  ? null
                  : BorderRadius.circular(radius),
              border: borderColor != null
                  ? Border.all(color: borderColor!)
                  : null,
              shape: (isCirclar ?? false)
                  ? BoxShape.circle
                  : BoxShape.rectangle,
            ),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..scaleByDouble(
                  getIt<AppPreferences>().lang == Constants.arLanguage
                      ? -1.0
                      : 1.0,
                  1.0,
                  1.0,
                  1.0,
                ),
              child: AppAssetImage(
                uri: icon,
                height: iconSize,
                width: iconSize,
                color: iconColor,
                fit: fit,
              ),
            ),
          ),
          titleIcon == null
              ? const SizedBox()
              : Text(
                  titleIcon!,
                  style: TextStyle(fontSize: 8, color: titleColor),
                ),
        ],
      ),
    );
  }
}

class AppIcon extends StatelessWidget {
  const AppIcon({super.key, this.icon, this.onTap});
  final Widget? icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.iconBgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor, width: 1),
            ),
            child:
                icon ??
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.textMain,
                  size: 5.w,
                ),
          ),
        ),
      ),
    );
  }
}
