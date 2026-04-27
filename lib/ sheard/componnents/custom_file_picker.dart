import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomFilePicker extends StatelessWidget {
  final File? selectedFile;
  final String? label;
  final String? hint;
  final Function(File file) onFilePicked;
  final VoidCallback onFileRemoved;

  const CustomFilePicker({
    super.key,
    this.selectedFile,
    this.label,
    this.hint,
    required this.onFilePicked,
    required this.onFileRemoved,
  });

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      onFilePicked(File(result.files.single.path!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyle.title.copyWith(
              color: AppColors.textMain,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 1.h),
        ],
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.backGround2,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedFile != null
                    ? AppColors.primary
                    : AppColors.borderColor,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: selectedFile == null
                ? Row(
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        color: AppColors.primary,
                        size: 6.w,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          hint ?? 'pick_file'.tr(),
                          style: AppTextStyle.body.copyWith(
                            color: AppColors.textSub,
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Icon(
                        Icons.insert_drive_file_rounded,
                        color: AppColors.primary,
                        size: 6.w,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedFile!.path
                                  .split(Platform.pathSeparator)
                                  .last,
                              style: AppTextStyle.body.copyWith(
                                color: AppColors.textMain,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'replace_file'.tr(),
                              style: AppTextStyle.smallBody.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: onFileRemoved,
                        icon: const Icon(
                          Icons.cancel_rounded,
                          color: AppColors.rose,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
