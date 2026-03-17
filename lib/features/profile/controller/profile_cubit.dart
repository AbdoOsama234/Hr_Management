import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../main_screen/controller/main_screen_cubit.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitial());

  String _name = 'Abdo';
  String _phone = '01117154507';
  String _jobTitle = 'mobile developer';
  String? _imagePath;
  String? _avatarUrl;

  final ImagePicker _picker = ImagePicker();

  /// 🔥 صورة موحدة
  String get displayImage {
    if (_imagePath != null && _imagePath!.isNotEmpty) {
      return _imagePath!;
    }
    if (_avatarUrl != null && _avatarUrl!.isNotEmpty) {
      return _avatarUrl!;
    }
    return '';
  }

  /// ================= INIT =================
  Future<void> loadProfile([MainScreenState? mainState]) async {
    try {
      emit(const ProfileLoading());

      if (mainState is MainScreenLoaded) {
        _name = mainState.dashboard.employeeName;
        _jobTitle = mainState.dashboard.jobTitle;
        _avatarUrl = mainState.dashboard.avatar;
      }

      /// fallback
      _name = _name.isNotEmpty ? _name : 'User Name';
      _jobTitle = _jobTitle.isNotEmpty ? _jobTitle : 'Mobile Developer';
      _phone = _phone.isNotEmpty ? _phone : '+966 5XX XXX XXX';

      emit(ProfileLoaded(
        name: _name,
        phone: _phone,
        jobTitle: _jobTitle,
        imagePath: _imagePath,
        avatarUrl: _avatarUrl,
      ));
    } catch (e) {
      emit(const ProfileError('Failed to load profile'));
    }
  }

  /// ================= EDIT =================

  void toggleEditMode() {
    if (state is! ProfileLoaded) return;

    final current = state as ProfileLoaded;
    emit(current.copyWith(isEditMode: !current.isEditMode));
  }

  void cancelEdit() {
    if (state is! ProfileLoaded) return;

    emit((state as ProfileLoaded).copyWith(isEditMode: false));
  }

  /// ================= UPDATE =================

  Future<void> updateProfile(String name, String phone) async {
    if (state is! ProfileLoaded) return;

    try {
      _name = name;
      _phone = phone;

      final current = state as ProfileLoaded;

      emit(current.copyWith(
        name: _name,
        phone: _phone,
        isEditMode: false,
        isUpdated: true,
      ));

      /// reset snackbar
      Future.delayed(const Duration(milliseconds: 300), () {
        if (isClosed) return;
        emit(current.copyWith(
          name: _name,
          phone: _phone,
          isEditMode: false,
          isUpdated: false,
        ));
      });
    } catch (e) {
      emit(const ProfileError('Failed to update profile'));
    }
  }

  /// ================= IMAGE =================

  Future<void> updateImage() async {
    if (state is! ProfileLoaded) return;

    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      _imagePath = pickedFile.path;

      final current = state as ProfileLoaded;

      emit(current.copyWith(
        imagePath: _imagePath,
      ));
    } catch (e) {
      emit(const ProfileError('Failed to update image'));
    }
  }
}