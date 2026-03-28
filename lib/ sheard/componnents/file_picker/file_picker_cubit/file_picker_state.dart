import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class FilePickerState extends Equatable {
  const FilePickerState();

  @override
  List<Object> get props => [];
}

class FilePickernInitial extends FilePickerState {}

class LoadingPickImageState extends FilePickerState {}

class PickImageState extends FilePickerState {
  final File? image;
  const PickImageState(this.image);
}

class LoadingRemoveImageState extends FilePickerState {}

class RemoveImageState extends FilePickerState {}

class LoadingPicklicenseState extends FilePickerState {}

class ScPicklicenseState extends FilePickerState {}

class LoadingRemovelicenseState extends FilePickerState {}

class ScRemovelicenseState extends FilePickerState {}

class StartNotValidLicenseState extends FilePickerState {}

class EndNotValidLicenseState extends FilePickerState {}
