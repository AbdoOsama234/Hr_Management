import 'package:hr_manegement/core/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/text_style.dart';

class SalarieContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color color;
  final bool isStart;
  final double height;
  const SalarieContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.color,
    this.isStart = false,
    this.height = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: isStart
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyle.subTitle.copyWith(color: AppColors.white),
          ),
          SizedBox(height: 2.h),
          Text(
            subTitle,
            style: AppTextStyle.subTitle.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
