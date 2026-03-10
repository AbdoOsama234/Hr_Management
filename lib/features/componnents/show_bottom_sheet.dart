import 'package:hr_manegement/core/helpers/luanch_url.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hr_manegement/features/componnents/app_asset_image.dart';
import 'package:hr_manegement/features/componnents/custom_button.dart';

import '../../../../core/app_sized_box.dart';
import 'app_logo.dart';

Future<dynamic> showAppBottomSheet({
  required BuildContext context,
  required String title,
  required Widget body,
  String? buttonTitle,
  Function? onTap,
  option2,
}) async {
  return await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width, // force width
    ),

    builder: (context) => Container(
      decoration: const BoxDecoration(
        color: AppColors.backGround2,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          Text(title, style: AppTextStyle.subHeadline),
          const SizedBox(height: 24),

          body,
          AppSizedBox.h2,
          if (buttonTitle != null && onTap != null) ...[
            AppSizedBox.h1,
            CustomButton(
              text: buttonTitle,
              onTap: () {
                onTap();
              },
            ),
          ],
        ],
      ),
    ),
  );
}

class BottomSheetOption {
  final String title;
  final Function onTap;
  final Color textColor;
  final Color backGroundColor;
  final Color borderColor;
  final String? icon;
  final Color iconColor;

  BottomSheetOption({
    required this.title,
    required this.onTap,
    this.iconColor = AppColors.primary,
    this.textColor = AppColors.primary,
    this.backGroundColor = AppColors.white,
    this.borderColor = AppColors.primary,
    this.icon,
  });
}

Future<dynamic> showAppOptionBottomSheet({
  required BuildContext context,
  required String title,
  required BottomSheetOption option1,
  required BottomSheetOption option2,
}) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width, // force width
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 27,
            height: 3,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 15),
          const AppLogoWidget(height: 100, width: 100),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.title.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                button(option: option1),
                const SizedBox(width: 10),
                button(option: option2),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
        ],
      ),
    ),
  );
}

Widget button({required BottomSheetOption option}) {
  return Expanded(
    child: InkWell(
      onTap: () {
        option.onTap();
      },
      hoverColor: Colors.transparent,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: option.backGroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: option.borderColor),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (option.icon != null) ...[
                AppAssetImage(
                  uri: option.icon!,
                  height: 23,
                  width: 23,
                  color: option.iconColor,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                option.title,
                style: AppTextStyle.smallBody.copyWith(color: option.textColor),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void showChooseMapBottomSheet({
  required BuildContext context,
  required LatLng latlong,
}) {
  showAppOptionBottomSheet(
    context: context,
    title: 'Please select your favourite app'.tr(),
    option1: BottomSheetOption(
      title: 'Google Maps'.tr(),
      icon: AppAssets.map1,
      onTap: () async {
        LaunchHelper.openGoogle(lat: latlong.latitude, lang: latlong.longitude);
        Navigator.of(context).pop(); // close the dialog
      },
    ),
    option2: BottomSheetOption(
      title: 'Waze Maps'.tr(),
      icon: AppAssets.waze,
      iconColor: AppColors.primary,
      onTap: () async {
        LaunchHelper.openWazeMap(
          lat: latlong.latitude,
          lang: latlong.longitude,
        );
        Navigator.of(context).pop(); // close the dialog
      },
    ),
  );
}
