import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/features/auth/view/widgets/title_row.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_sized_box.dart';
import '../../../../core/app_validation.dart' show Validations;
import '../../../componnents/custom_app_bar.dart';
import '../../../componnents/custom_button.dart';
import '../../../componnents/custom_text_field.dart';
import '../widgets/auth_header.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Change Password'.tr()),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthHeader(
                subtitle: 'Please enter your new password to reset it'.tr(),
              ),
              AppSizedBox.h3,
              TitleRow(title: 'Password'.tr(), icon: Icons.phone),
              AppSizedBox.h1,
              CustomTextField(
                controller: _newPasswordController,
                hint: 'password...'.tr(),
                type: TextInputType.visiblePassword,
                validator: Validations.passwordValidation,
              ),

              AppSizedBox.h3,
              TitleRow(title: 'Confirm Password'.tr(), icon: Icons.phone),
              AppSizedBox.h1,
              CustomTextField(
                controller: _confirmPasswordController,
                hint: 'confirm password...'.tr(),
                type: TextInputType.visiblePassword,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'This field is required'.tr();
                  } else if (val.length < 6) {
                    return 'Password must be at least 6 characters'.tr();
                  } else if (val != _newPasswordController.text) {
                    return 'Passwords do not match'.tr();
                  }
                  return null;
                },
                prefix: Icon(
                  Icons.lock_outline,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),

              AppSizedBox.h6,

              CustomButton(
                text: 'Submit'.tr(),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement change password logic with Cubit
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                },
              ),

              AppSizedBox.h3,
            ],
          ),
        ),
      ),
    );
  }
}
