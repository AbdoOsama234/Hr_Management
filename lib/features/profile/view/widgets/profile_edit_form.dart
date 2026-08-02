import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

import '../../../../ sheard/componnents/custom_button.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../controller/profile_cubit.dart';

class ProfileEditForm extends StatefulWidget {
  final String name;
  final String phone;
  final String jobTitle;

  const ProfileEditForm({
    super.key,
    required this.name,
    required this.phone,
    required this.jobTitle,
  });

  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _jobTitleController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _phoneController = TextEditingController(text: widget.phone);
    _jobTitleController = TextEditingController(text: widget.jobTitle);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _jobTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: AppColors.backGround2,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit_note_rounded,
                    color: AppColors.primary,
                    size: 6.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'edit_profile'.tr(),
                    style: AppTextStyle.title.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMain,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),

              AppSizedBox.h3,

              // Name
              Text(
                'full_name'.tr(),
                style: AppTextStyle.body.copyWith(
                  color: AppColors.textSub,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 0.8.h),
              CustomTextField(
                controller: _nameController,
                hint: 'enter_name'.tr(),
                type: TextInputType.name,
                radius: 14,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'name_required'.tr();
                  }
                  return null;
                },
                prefix: Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.primary,
                  size: 5.w,
                ),
              ),

              AppSizedBox.h2,

              // Phone
              Text(
                'phone_number'.tr(),
                style: AppTextStyle.body.copyWith(
                  color: AppColors.textSub,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 0.8.h),
              CustomTextField(
                controller: _phoneController,
                hint: 'enter_phone'.tr(),
                type: TextInputType.phone,
                radius: 14,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'phone_required'.tr();
                  }
                  return null;
                },
                prefix: Icon(
                  Icons.phone_outlined,
                  color: AppColors.primary,
                  size: 5.w,
                ),
              ),

              AppSizedBox.h2,

              // Job Title
              Text(
                'job_title'.tr(),
                style: AppTextStyle.body.copyWith(
                  color: AppColors.textSub,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 0.8.h),
              CustomTextField(
                controller: _jobTitleController,
                hint: 'job_title'.tr(),
                type: TextInputType.text,
                radius: 14,
                enable: false,
                readOnly: true,
                validator: (value) => null,
                prefix: Icon(
                  Icons.work_outline_rounded,
                  color: AppColors.textSub.withValues(alpha: 0.5),
                  size: 5.w,
                ),
              ),

              AppSizedBox.h3,

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.read<ProfileCubit>().cancelEdit(),
                      child: Container(
                        height: 6.4.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'cancel'.tr(),
                            style: AppTextStyle.title.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: CustomButton(
                      text: 'save'.tr(),
                      radius: 14,
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ProfileCubit>().updateProfile(
                            _nameController.text.trim(),
                            _phoneController.text.trim(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
