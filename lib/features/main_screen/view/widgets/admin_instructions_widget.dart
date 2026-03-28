import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

import '../../../../my_app.dart';

class AdminInstructionsWidget extends StatelessWidget {
  const AdminInstructionsWidget({
    super.key,
  });

  String _getTitle() {
    return "admin_instructions";
  }

  String _getInstructions() {
    return "admin_instructions_desc";
  }

  @override
  Widget build(BuildContext context) {
    final title = _getTitle();
    final instructions = _getInstructions();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.h),
      decoration: BoxDecoration(
        color: AppColors.backGround2,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: MyApp.isDark
                      ? AppColors.primary.withOpacity(0.12)
                      : AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.assignment_rounded,
                  color: AppColors.primary,
                  size: 5.w,
                ),
              ),
              SizedBox(width: 2.5.w),
              Expanded(
                child: Text(
                  title.tr(),
                  maxLines: 2,
                  style: AppTextStyle.title.copyWith(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          AppSizedBox.h2,

          /// Instructions
          Text(
            instructions.tr(),
            style: AppTextStyle.body.copyWith(
              color: AppColors.textSub,
            ),
          ),
        ],
      ),
    );
  }
}