import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'dart:ui' as ui;

import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/custom_button.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_sized_box.dart';
import '../../../../core/extensions.dart';
import '../../../../core/text_style.dart';

import '../widgets/auth_header.dart';
import 'change_password_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 15.w,
      height: 15.w,
      textStyle: AppTextStyle.headline.copyWith(color: AppColors.textMain),
      decoration: BoxDecoration(
        color: AppColors.backGround, // Use background color
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.iconBorderColor, width: 2),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.red),
    );

    return Scaffold(
      appBar: CustomAppBar(title: 'OTP Verification'.tr()),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthHeader(
                subtitle: 'Enter your OTP code to verify your identity'.tr(),
              ),

              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: Pinput(
                  controller: _otpController,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  errorPinTheme: errorPinTheme,

                  validator: (s) {
                    return s == null || s.length < 4
                        ? 'Please Enter Valid OTP'.tr()
                        : null;
                  },
                ),
              ),

              AppSizedBox.h4,

              Align(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    // TODO: Implement resend OTP logic
                  },
                  child: Text(
                    'Resend OTP'.tr(),
                    style: AppTextStyle.subTitle.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              AppSizedBox.h6,

              CustomButton(
                text: 'Verify'.tr(),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement OTP verification logic with Cubit
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen(),
                      ),
                    );
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
