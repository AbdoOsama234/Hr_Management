import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_sized_box.dart';
import '../../../../core/text_style.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textMain),
        AppSizedBox.w2,

        Text(title.tr(), style: AppTextStyle.title),
        const Spacer(),
      ],
    );
  }
}
