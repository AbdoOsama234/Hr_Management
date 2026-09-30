import 'package:flutter/material.dart';
import 'package:hr_manegement/core/extensions.dart';

import '../../../../core/app_assets.dart';

class AppAssetImage extends StatelessWidget {
  const AppAssetImage({
    super.key,
    required this.uri,
    this.height,
    this.fit,
    this.width,
    this.color,
  });
  final String uri;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      uri,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      color: color,
      errorBuilder: (context, error, stackTrace) {
        return Image(
          fit: fit ?? BoxFit.cover,
          image:  AssetImage(AppAssets.appLogo),
          height: height ?? 15.w,
          width: width ?? 15.w,
        );
      },
    );
  }
}
