import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/features/main_screen/view/screens/main_screen.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_sized_box.dart';
import '../../../../core/app_validation.dart';
import '../../../../core/text_style.dart';
import '../../../componnents/code_picker_textfield.dart';
import '../../../componnents/custom_button.dart';
import '../../../componnents/custom_text_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/title_row.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSizedBox.h4,
              AuthHeader(
                title: 'Login'.tr(),
                subtitle: 'Welcome To Halacar Employee Management'.tr(),
              ),
              TitleRow(title: 'Phone'.tr(), icon: Icons.phone),
              AppSizedBox.h1,
              CodePickerTextFieldTwo(
                controller: _phoneController,
                labelText: 'Phone...'.tr(),
              ),

              TitleRow(title: 'Password'.tr(), icon: Icons.lock),
              AppSizedBox.h1,
              CustomTextField(
                controller: _passwordController,
                hint: 'password...'.tr(),
                type: TextInputType.visiblePassword,
                validator: Validations.passwordValidation,
              ),

              AppSizedBox.h2,

              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Forget Password?'.tr(),
                    style: AppTextStyle.subTitle.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              AppSizedBox.h3,

              CustomButton(
                text: 'Login'.tr(),
                onTap: () {
                  // if (_formKey.currentState!.validate()) {
                  // TODO: Implement actual login logic with Cubit here
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (route) => false,
                  );
                  //}
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
