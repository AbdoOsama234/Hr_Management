import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/%20sheard/componnents/screen_builder/screen_builder.dart';
import 'package:hr_manegement/%20sheard/componnents/show_app_toast.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/features/auth/controller/login_cubit.dart';
import 'package:hr_manegement/features/auth/data/repository/auth_repository.dart';
import 'package:hr_manegement/features/main_screen/view/screens/main_screen.dart';
import '../../../../ sheard/componnents/custom_button.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_sized_box.dart';
import '../../../../core/app_validation.dart';
import '../../../../core/text_style.dart';

import '../widgets/auth_header.dart';
import '../widgets/title_row.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
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
                TitleRow(title: 'Email'.tr(), icon: Icons.email),
                AppSizedBox.h1,
                // CodePickerTextFieldTwo(
                //   controller: _emailController,
                //   labelText: 'Phone...'.tr(),
                // ),
                CustomTextField(
                  controller: _emailController,
                  hint: 'Email...'.tr(),
                  type: TextInputType.emailAddress,
                  validator: Validations.emailValidation,
                ),
                AppSizedBox.h3,

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
                BlocConsumer<LoginCubit, LoginState>(
                  buildWhen: (previous, current) =>
                      current is LoginLoading ||
                      current is LoginSuccess ||
                      current is LoginError,
                  builder: (context, state) {
                    var cubit = LoginCubit.get(context);
                    return CustomApiBuilderView(
                      isLoading: state is LoginLoading,
                      isError: state is LoginError,
                      showErrorView: false,
                      showEmptyView: false,

                      contentBuilder: () => CustomButton(
                        text: 'Login'.tr(),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                      ),

                      onRetry: () => cubit.login(
                        _emailController.text,
                        _passwordController.text,
                      ),
                      errorMessage: state is LoginError ? state.error : null,
                    );
                  },
                  listener: (BuildContext context, LoginState state) {
                    if (state is LoginSuccess) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                        (route) => false,
                      );
                    } else if (state is LoginError) {
                      CustomToast.show(
                        message: state.error,
                        type: ToastType.error,
                      );
                    }
                  },
                ),

                AppSizedBox.h3,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
