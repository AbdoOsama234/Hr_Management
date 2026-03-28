import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'app_asset_image.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    super.key,
    this.size = 50,
    this.color = AppColors.primary,
  });
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.threeArchedCircle(size: size, color: color);
  }
}

class LogoLoaderWidget extends StatelessWidget {
  const LogoLoaderWidget({
    super.key,
    this.height,
    this.color = AppColors.primary,
  });
  final double? height;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return AppAssetImage(
      uri: AppAssets.loadingLogo,
      fit: BoxFit.cover,
      height: height ?? 30.h,
      color: color,
    );
  }
}
