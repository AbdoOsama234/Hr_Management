import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/app_sized_box.dart';
import '../../../../core/text_style.dart';

class AuthHeader extends StatelessWidget {
  final String? title;
  final String subtitle;

  const AuthHeader({super.key, this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSizedBox.h4,
        Center(
          child: Image.asset(
            AppAssets.appLogo,
            height: 15.h,
            width: 40.w,
            fit: BoxFit.contain,
          ),
        ),
        if (title != null) ...[
          Text(
            title!.tr(),
            style: AppTextStyle.headline.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          AppSizedBox.h2,
        ],

        Text(
          subtitle.tr(),
          style: AppTextStyle.body.copyWith(color: AppColors.textSub),
          textAlign: TextAlign.center,
        ),
        AppSizedBox.h4,
      ],
    );
  }
}
