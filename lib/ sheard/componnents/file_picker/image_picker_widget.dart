// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/extensions.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_sized_box.dart';
import '../../../../../core/helpers/document_helper/document_picker.dart';
import '../../../../../core/text_style.dart';
import '../app_asset_image.dart';
import '../app_logo.dart';
import '../icon_button.dart' show AppMainIconButton;
import '../show_bottom_sheet.dart';
import 'file_picker_cubit/file_picker_cubit.dart';
import 'file_picker_cubit/file_picker_state.dart';

class ImagePickerWidget extends StatelessWidget {
  final String? imageLink;
  final bool isCirclar;
  const ImagePickerWidget({super.key, this.imageLink, this.isCirclar = true});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return isCirclar ? circlarImageWidget() : rectangleImageWiget();
      },
    );
  }

  Widget rectangleImageWiget() {
    return BlocBuilder<FilePickerCubit, FilePickerState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<FilePickerCubit>(context);
        File? userImage = cubit.image;
        return Row(
          children: [
            GestureDetector(
              onTap: onCameraTap(userImage, context),
              child: Container(
                height: 23.w,
                width: 23.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.iconBackGround,
                ),
                child: const AppAssetImage(
                  uri: AppAssets.add,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            AppSizedBox.w5,
            if (userImage != null) imageItem(),
          ],
        );
      },
    );
  }

  Widget imageItem() {
    return BlocBuilder<FilePickerCubit, FilePickerState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<FilePickerCubit>(context);
        File? userImage = cubit.image;
        return Stack(
          children: [
            GestureDetector(
              //onTap: () => viewImage(index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  userImage!,
                  height: 23.w,
                  width: 23.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () => cubit.removeImage(),
                child: CircleAvatar(
                  backgroundColor: Colors.red.withValues(alpha: 0.8),
                  radius: 12,
                  child: const Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget circlarImageWidget() {
    return BlocBuilder<FilePickerCubit, FilePickerState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<FilePickerCubit>(context);
        File? userImage = cubit.image;
        return InkWell(
          onTap: onCameraTap(userImage, context),
          child: SizedBox(
            width: 120,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.white,
                  backgroundImage: userImage != null
                      ? FileImage(userImage)
                      : (imageLink != null && imageLink != "")
                      ? NetworkImage(imageLink ?? "")
                            //? NetworkImage(getImageUrl(imageLink))
                            as ImageProvider
                      : null,
                  child:
                      userImage == null &&
                          (imageLink == null || imageLink == "")
                      ? const AppLogoWidget(width: 100)
                      : null,
                ),
                cameraIconWidget(cubit),
              ],
            ),
          ),
        );
      },
    );
  }

  Function()? onCameraTap(File? userImage, BuildContext context) {
    return userImage == null
        ? () async {
            var result = await showImagePikerDialog(context);
            if (result != null) {
              await BlocProvider.of<FilePickerCubit>(context).pickImage(result);
            }
          }
        : null;
  }

  Future<dynamic> showImagePikerDialog(BuildContext context) async {
    var result = showAppOptionBottomSheet(
      context: context,
      title: "Add Image with".tr(),
      option1: BottomSheetOption(
        title: "Camera".tr(),
        icon: AppAssets.camera1,
        onTap: () async {
          Navigator.pop(context, PickImageFromEnum.camera);
        },
      ),
      option2: BottomSheetOption(
        title: "From Gallery".tr(),
        icon: AppAssets.gallery,
        onTap: () async {
          Navigator.pop(context, PickImageFromEnum.gallery);
        },
      ),
    );

    return result;
  }

  Widget imageTypeWidget(IconData icon, String text, Function onTap) {
    return Builder(
      builder: (context) {
        return Material(
          color: AppColors.white,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
            onTap: () => onTap(),
            child: Container(
              padding: EdgeInsets.all(10.sp),
              width: 30.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 35.sp, color: AppColors.primary),
                  AppSizedBox.h2,
                  Text(
                    text,
                    style: AppTextStyle.subTitle.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget cameraIconWidget(FilePickerCubit cubit) {
    File? userImage = cubit.image;
    return UnconstrainedBox(
      child: Builder(
        builder: (context) {
          return Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: AppMainIconButton(
                isCirclar: true,
                iconColor: AppColors.white,
                icon: userImage == null ? AppAssets.camera1 : AppAssets.delete,
                onTap: userImage != null
                    ? () {
                        cubit.removeImage();
                      }
                    : () async {
                        var result = await showImagePikerDialog(context);
                        if (result != null) {
                          await cubit.pickImage(result);
                        }
                      },
              ),
            ),
          );
        },
      ),
    );
  }
}
