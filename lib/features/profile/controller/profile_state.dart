abstract class ProfileState {
  const ProfileState();
}

/// 🟡 Initial
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// 🔄 Loading
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// ❌ Error
class ProfileError extends ProfileState {
  final String? message;

  const ProfileError([this.message]);
}

/// ✅ Loaded
class ProfileLoaded extends ProfileState {
  final String name;
  final String phone;
  final String jobTitle;
  final String? imagePath;
  final String? avatarUrl;
  final bool isEditMode;
  final bool isUpdated;

  const ProfileLoaded({
    required this.name,
    required this.phone,
    required this.jobTitle,
    this.imagePath,
    this.avatarUrl,
    this.isEditMode = false,
    this.isUpdated = false,
  });

  ProfileLoaded copyWith({
    String? name,
    String? phone,
    String? jobTitle,
    String? imagePath,
    String? avatarUrl,
    bool? isEditMode,
    bool? isUpdated,
  }) {
    return ProfileLoaded(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      jobTitle: jobTitle ?? this.jobTitle,
      imagePath: imagePath ?? this.imagePath,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isEditMode: isEditMode ?? this.isEditMode,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }
}