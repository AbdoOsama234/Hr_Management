import 'dart:io';

import 'package:hr_manegement/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../../../../core/helpers/document_helper/document_picker.dart';
import 'file_picker_state.dart';

class FilePickerCubit extends Cubit<FilePickerState> {
  FilePickerCubit() : super(FilePickernInitial());

  static FilePickerCubit get(BuildContext context) =>
      context.read<FilePickerCubit>();

  File? image;
  DocumentHelper documentHelper = DocumentHelper();
  Future<void> pickImage(PickImageFromEnum imageType) async {
    image = await documentHelper.pickImage(imageType);
    File? cropedImage;
    if (image != null) {
      cropedImage = await cropImage(image!);
    }
    if (cropedImage != null) {
      image = cropedImage;
    }

    emit(PickImageState(image));
  }

  // Future<void> pickImage(PickImageFromEnum imageType) async {
  //   File? picked = await documentHelper.pickImage(imageType);
  //   if (picked != null) {
  //     File? cropped = await cropImage(picked);
  //     if (cropped != null) {
  //       image = cropped;
  //       emit(PickImageState(image));
  //     }
  //   }
  // }
  void removeImage() {
    image = null;
    emit(RemoveImageState());
  }

  File? localFile;
  String? localFilePath;
  Future<void> picklFile() async {
    emit(LoadingPicklicenseState());
    File? file = await documentHelper.pickFile();
    if (file != null) {
      localFile = file;
      localFilePath = file.path.split('/').last;
      emit(ScPicklicenseState());
    }
  }

  void removeFile() {
    emit(LoadingRemovelicenseState());
    localFile = null;
    localFilePath = null;
    emit(ScRemovelicenseState());
  }

  Future<File?> cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Crop Image', aspectRatioLockEnabled: false),
      ],
    );

    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }
}
