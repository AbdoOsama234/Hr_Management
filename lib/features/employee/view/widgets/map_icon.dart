import 'package:flutter/material.dart';
import 'package:hr_manegement/%20sheard/componnents/app_asset_image.dart';

import '../../../../ sheard/componnents/app_network_image.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/text_style.dart';


class MapIcon extends StatefulWidget {
  const MapIcon({
    super.key,
    required this.image,
    this.onTap,
    this.placeHolder,
    required this.name,
  });

  final String image;
  final String name;
  final String? placeHolder;
  final Function()? onTap;

  @override
  State<MapIcon> createState() => _MapIconState();
}

class _MapIconState extends State<MapIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(1000)),
              child: AppAssetImage(
                uri: widget.image,
                fit: BoxFit.contain,
                height: 50,
                width: 50,
                // placeHolder: widget.placeHolder ?? AppAssets.avatar,
              ),
            ),
            SizedBox(height: 5,),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.smallBody.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}