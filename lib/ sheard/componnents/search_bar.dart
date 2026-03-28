import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_sized_box.dart';
import 'app_asset_image.dart';
import 'custom_text_field.dart';
import 'icon_button.dart' show AppMainIconButton;

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    required this.controller,
    this.validator,
    this.hint,
    this.onSave,
    this.onChange,
    this.onTap,
    this.onFieldSubmitted,
    this.onFiterTap,
    this.readOnly = false,
    this.icon = AppAssets.filter,
    this.onTapIconButton,
    this.type,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hint;
  final Function(String)? onSave;
  final Function(String)? onChange;
  final String icon;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onFiterTap;
  final dynamic Function()? onTapIconButton;
  final bool readOnly;
  final TextInputType? type;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            readOnly: readOnly,
            controller: controller,
            hint: hint ?? 'Search by name'.tr(),
            type: type ?? TextInputType.text,
            onChange: onChange,
            onFieldSubmitted: onFieldSubmitted,
            onTap: onTap,
            onSaved: onSave,
            prefix: const AppAssetImage(
              uri: AppAssets.search,
              color: AppColors.primary,
              fit: BoxFit.scaleDown,
              width: 23,
              height: 23,
            ),
            // radius: Constants.defaultSearshRadius,
            validator: (value) {
              return null;
              // return validator != null
              //     ? validator!(value)
              //     : Validations.normalValidation(value);
            },
          ),
        ),
        AppSizedBox.w2,
        AppMainIconButton(
          isCirclar: true,
          borderColor: AppColors.primary,
          icon: icon,
          iconColor: AppColors.primary,
          padding: 10,
          onTap: () {
            if (onTapIconButton != null) {
              onTapIconButton!();
            }
          },
        ),
      ],
    );
  }
}
