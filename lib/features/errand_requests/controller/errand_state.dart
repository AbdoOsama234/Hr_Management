abstract class ErrandState {}

/// =========================
/// 🔹 INITIAL
/// =========================
class ErrandInitial extends ErrandState {}

/// =========================
/// 🔹 GET ALL
/// =========================
class GetAllErrandsLoading extends ErrandState {}

class GetAllErrandsLoaded extends ErrandState {}

class GetAllErrandsError extends ErrandState {
  final String? error;

  GetAllErrandsError({this.error});
}

class ErrandEmpty extends ErrandState {}

/// =========================
/// 🔄 PAGINATION
/// =========================
class PaginationLoading extends ErrandState {}

/// =========================
/// ➕ CREATE
/// =========================
class CreateErrandLoading extends ErrandState {}

class CreateErrandSuccess extends ErrandState {}

class CreateErrandError extends ErrandState {
  final String? error;

  CreateErrandError({this.error});
}

/// =========================
/// 🗑 DELETE
/// =========================
class DeleteErrandLoading extends ErrandState {
  final int id;

  DeleteErrandLoading({required this.id});
}

class DeleteErrandSuccess extends ErrandState {}

class DeleteErrandError extends ErrandState {
  final String? error;

  DeleteErrandError({this.error});
}

/// =========================
/// ✏ UPDATE
/// =========================
class UpdateErrandLoading extends ErrandState {
  final int id;

  UpdateErrandLoading({required this.id});
}

class UpdateErrandSuccess extends ErrandState {}

class UpdateErrandError extends ErrandState {
  final String? error;

  UpdateErrandError({this.error});
}
