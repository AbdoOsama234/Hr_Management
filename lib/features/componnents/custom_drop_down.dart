import 'package:hr_manegement/core/text_style.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import 'custom_text_field.dart';

class CustomDropDownMenu extends StatelessWidget {
  final String label;
  final dynamic value;
  final Widget? prefixIcon;
  final List<DropdownMenuItem> items;
  final ValueChanged onChanged;
  final String? Function(dynamic)? validator;
  const CustomDropDownMenu({
    super.key,
    required this.label,
    this.prefixIcon,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items,
      onChanged: onChanged,
      value: value,
      validator: validator,
      dropdownColor: AppColors.backGround2,
      style: AppTextStyle.body.copyWith(color: AppColors.textMain),
      icon: Padding(
        padding: EdgeInsetsDirectional.only(end: 2.w),
        child: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.primary,
          size: 28,
        ),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.iconBackGround.withOpacity(0.05),
        hintText: label,
        labelText: label,
        labelStyle: AppTextStyle.title.copyWith(
          color: AppColors.textSub.withOpacity(0.6),
        ),
        hintStyle: AppTextStyle.body.copyWith(
          color: AppColors.textSub.withOpacity(0.4),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        prefixIcon: prefixIcon,
        enabledBorder: enabledBorder(radius: 10),
        border: border(radius: 10),
        disabledBorder: disabledBorder(radius: 10),
        focusedBorder: focusedBorder(radius: 10),
        focusedErrorBorder: errorBorder(radius: 10),
        errorBorder: errorBorder(radius: 10),
      ),
    );
  }
}
