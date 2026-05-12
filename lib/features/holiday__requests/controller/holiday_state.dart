abstract class HolidayState {}

class HolidayInitial extends HolidayState {}

/// 📥 GET
class GetAllHolidaysLoading extends HolidayState {}

class GetAllHolidaysLoaded extends HolidayState {}

class GetAllHolidaysError extends HolidayState {
  final String? error;

  GetAllHolidaysError({this.error});
}

/// 🔄 Pagination
class PaginationLoading extends HolidayState {}

/// ➕ CREATE
class CreateHolidayLoading extends HolidayState {}

class CreateHolidaySuccess extends HolidayState {}

class CreateHolidayError extends HolidayState {
  final String? error;

  CreateHolidayError({this.error});
}

/// 🗑 DELETE
class DeleteHolidayLoading extends HolidayState {
  final int id;

  DeleteHolidayLoading({required this.id});
}

class DeleteHolidaySuccess extends HolidayState {
  Null get error => null;
}

class DeleteHolidayError extends HolidayState {
  final String? error;

  DeleteHolidayError({this.error});
}


///UPDATE
class UpdateHolidayLoading extends HolidayState {
  final int id;

  UpdateHolidayLoading({required this.id});
}

class UpdateHolidaySuccess extends HolidayState {
  Null get error => null;
}

class UpdateHolidayError extends HolidayState {
  final String? error;

  UpdateHolidayError({this.error});
}