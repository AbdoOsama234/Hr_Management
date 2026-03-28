import 'package:flutter/material.dart';


import '../../../../core/app_assets.dart';
import 'app_asset_image.dart';

class BigAppLogoWidget extends StatelessWidget {
  const BigAppLogoWidget({
    super.key,
    this.height = 150,
    this.width = 150,
    this.padding = 45,
  });
  final double height;
  final double width;

  final double padding;

  @override
  Widget build(BuildContext context) {
    return AppLogoWidget(height: height, width: width, padding: padding);
  }
}

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
    this.height = 80,
    this.width = 80,
    this.padding = 0,
  });
  final double? height;
  final double? width;

  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding!),
      child: AppAssetImage(
        uri: AppAssets.appLogo,
        fit: BoxFit.contain,
        height: height,
        width: width,
      ),
    );
  }
}
