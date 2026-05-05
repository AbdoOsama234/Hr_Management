import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

import 'app_asset_image.dart';
import 'custom_button.dart';

class EmptyScreen extends StatefulWidget {
  const EmptyScreen({
    super.key,
    required this.title,
    this.image,
    this.description,
    this.buttonText,
    this.onTap,
    this.titleColor,
    this.descriptionColor,
    this.imageColor,
  });
  final String title;
  final String? image;
  final String? description;
  final String? buttonText;
  final Color? titleColor;
  final Color? descriptionColor;
  final Function? onTap;
  final Color? imageColor;
  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppAssetImage(
            uri: widget.image ?? AppAssets.appLogo,
            width: 50.w,
            color: widget.imageColor,
            fit: BoxFit.contain,
          ),
          AppSizedBox.h2,
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: AppTextStyle.title.copyWith(
              color: widget.titleColor ?? AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSizedBox.h2,
          if (widget.description != null) ...[
            Text(
              widget.description!,
              textAlign: TextAlign.center,
              style: AppTextStyle.subTitle.copyWith(
                color: widget.descriptionColor ?? AppColors.grey,
              ),
            ),
            AppSizedBox.h5,
          ],

          if (widget.buttonText != null && widget.onTap != null) ...[
            CustomButton(
              text: widget.buttonText!,
              width: 90.w,
              height: 6.h,
              radius: Constants.defaultSearshRadius,
              onTap: () {
                widget.onTap!();
              },
            ),
          ],
        ],
      ),
    );
  }
}
