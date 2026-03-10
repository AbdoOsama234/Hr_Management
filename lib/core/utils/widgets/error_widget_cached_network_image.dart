import 'dart:io';

import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/utils/functions/function_utils.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/features/componnents/app_asset_image.dart';

import '../../app_assets.dart';

class ErrorWidgetCachedNetworkImage extends StatelessWidget {
  const ErrorWidgetCachedNetworkImage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAssetImage(
      height: 60.w,
      width: 60.w,
      uri: isEnglish(Platform.localeName)
          ? AppAssets.appLogo
          : AppAssets.appLogoAr,
      fit: BoxFit.contain,
    );
  }
}
