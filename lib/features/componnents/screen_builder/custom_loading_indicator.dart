import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 80.w,
        height: 80.h,
        child: const LoadingIndicator(
          indicatorType: Indicator.ballScale,
          colors: [AppColors.primary],
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class CustomErrorView extends StatelessWidget {
  const CustomErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.error_outline, color: AppColors.error, size: 50),
    );
  }
}

class CustomEmptyDataView extends StatelessWidget {
  const CustomEmptyDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('no_data_to_preview', style: AppTextStyle.hint));
  }
}
