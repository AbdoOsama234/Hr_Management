import 'dart:io';

import 'package:hr_manegement/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/app_assets.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/app_sized_box.dart';
import '../../../../../core/text_style.dart';

import '../app_dialoge.dart';
import 'file_picker_cubit/file_picker_cubit.dart';
import 'file_picker_cubit/file_picker_state.dart';

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget pickFileWidget({double? horizontalPadding, bool validator = true}) {
    return BlocBuilder<FilePickerCubit, FilePickerState>(
      builder: (context, state) {
        FilePickerCubit cubit = FilePickerCubit.get(context);
        return FormField<File>(
          initialValue: cubit.localFile,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (File? file) {
            if (!validator) {
              if (file == null && !cubit.documentHelper.isValid) {
                showErorrAppDialog(
                  context: context,
                  title: 'MyApp.tr.error',
                  message: 'MyApp.tr.pleaseAddLicense',
                );
                // WidgetsBinding.instance.addPostFrameCallback(
                //   (_) async => await popDialog(
                //     context: context,
                //     title: MyApp.tr.error,
                //     content: MyApp.tr.pleaseAddLicense,
                //     boxColor: AppColors.error,
                //   ),
                // );
                cubit.documentHelper.isValid = true;
                return null;
              }
              return null;
            }
            if (file == null) {
              return 'MyApp.tr.pleaseAddLicense';
            }
            return null;
          },
          builder: (state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding ?? 5.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MyApp.tr.marketLicense', style: AppTextStyle.subHint),
                  AppSizedBox.h1,
                  addFileButton(state),
                  if (cubit.localFile != null) AppSizedBox.h2,
                  if (cubit.localFile != null) fileRow(state),
                  AppSizedBox.h1,
                  if (state.hasError &&
                      state.errorText != null &&
                      state.errorText != "")
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        state.errorText!,
                        style: AppTextStyle.subHint,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget addFileButton(FormFieldState<File> fieldState) {
    //print(AppAssets.addIcon);
    return BlocBuilder<FilePickerCubit, FilePickerState>(
      builder: (context, state) {
        FilePickerCubit cubit = FilePickerCubit.get(context);
        return Material(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(2.sp),
          child: InkWell(
            borderRadius: BorderRadius.circular(2.sp),
            onTap: cubit.localFile == null
                ? () async {
                    await cubit.picklFile();
                    fieldState.didChange(cubit.localFile);
                  }
                : null,
            child: Container(
              height: 13.h,
              width: 90.w,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(2.sp),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(AppAssets.add, height: 10.h),
            ),
          ),
        );
      },
    );
  }

  Widget fileRow(FormFieldState<File> fieldState) {
    return BlocBuilder<FilePickerCubit, FilePickerState>(
      builder: (context, state) {
        FilePickerCubit cubit = FilePickerCubit.get(context);
        return Row(
          children: [
            Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  cubit.removeFile();
                  fieldState.didChange(cubit.localFile);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.w),
                  child: SvgPicture.asset(AppAssets.logout),
                ),
              ),
            ),
            AppSizedBox.w3,
            Expanded(
              child: Text(cubit.localFilePath!, style: AppTextStyle.subHint),
            ),
          ],
        );
      },
    );
  }
}
