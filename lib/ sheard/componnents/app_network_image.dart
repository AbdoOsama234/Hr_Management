import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/app_colors.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.uri,
    this.height,
    this.width,
    this.fit,
    this.cacheWidth,
    this.cacheHeight,
    this.filterQuality = FilterQuality.low,
  });
  final String uri;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width ?? 15.w,
      height: height ?? 15.w,
      fit: fit ?? BoxFit.cover,
      imageUrl: uri,
      maxWidthDiskCache: cacheWidth,
      maxHeightDiskCache: cacheHeight,
      filterQuality: filterQuality,
      placeholder: (context, url) {
        return LoadingAnimationWidget.inkDrop(
          size: 30,
          color: AppColors.primary,
        );
      },
      errorWidget: (context, url, error) => ClipOval(
        child: Image(
          fit: BoxFit.scaleDown,
          image: const AssetImage(AppAssets.appLogo),
          width: width ?? 15.w,
          height: height ?? 15.w,
        ),
      ),
    );
  }
}
