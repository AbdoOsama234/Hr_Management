abstract class PermissionState {}

class PermissionInitial extends PermissionState {}

/// 📥 GET
class GetAllPermissionsLoading extends PermissionState {}

class GetAllPermissionsLoaded extends PermissionState {}

class GetAllPermissionsError extends PermissionState {
  final String? error;

  GetAllPermissionsError({this.error});
}

/// 🔄 Pagination
class PaginationLoading extends PermissionState {}

/// ➕ CREATE
class CreatePermissionLoading extends PermissionState {}

class CreatePermissionSuccess extends PermissionState {}

class CreatePermissionError extends PermissionState {
  final String? error;

  CreatePermissionError({this.error});
}

/// 🗑 DELETE
class DeletePermissionLoading extends PermissionState {
  final int id;

  DeletePermissionLoading({required this.id});
}

class DeletePermissionSuccess extends PermissionState {}

class DeletePermissionError extends PermissionState {
  final String? error;

  DeletePermissionError({this.error});
}

/// 🔄 UPDATE
class UpdatePermissionLoading extends PermissionState {
  final int id;

  UpdatePermissionLoading({required this.id});
}

class UpdatePermissionSuccess extends PermissionState {}

class UpdatePermissionError extends PermissionState {
  final String? error;

  UpdatePermissionError({this.error});
}
