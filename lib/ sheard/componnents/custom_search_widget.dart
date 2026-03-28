import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/constants.dart';
import 'app_asset_image.dart';
import 'custom_text_field.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({super.key, required this.controller, this.hint, this.onChange, this.onTap, this.onFieldSubmitted, this.onSaved});
  final TextEditingController controller;
  final String? hint;
  final Function(String)? onChange;
  final void Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final void Function(String)? onSaved;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        controller: controller,
        hint: hint ?? 'Search by name'.tr(),
        type: TextInputType.text,
        onChange: onChange,
        onFieldSubmitted: onFieldSubmitted,
        onTap: onTap,
        onSaved: onSaved,
        prefix: const AppAssetImage(
          uri: AppAssets.search,
          fit: BoxFit.scaleDown,
          width: 23,
          height: 23,
        ),
        radius: Constants.defaultSearshRadius,
        validator: (value) {
          return null;
          // return validator != null
          //     ? validator!(value)
          //     : Validations.normalValidation(value);
        }
    );
  }
}
