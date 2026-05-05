abstract class BusinessTripState {}

class BusinessTripInitial extends BusinessTripState {}

/// 📥 GET
class GetAllTripsLoading extends BusinessTripState {}

class GetAllTripsLoaded extends BusinessTripState {}

class GetAllTripsError extends BusinessTripState {
  final String? error;

  GetAllTripsError({this.error});
}

/// 🔄 Pagination
class PaginationLoading extends BusinessTripState {}

/// ➕ CREATE
class CreateTripLoading extends BusinessTripState {}

class CreateTripSuccess extends BusinessTripState {}

class CreateTripError extends BusinessTripState {
  final String? error;

  CreateTripError({this.error});
}

/// 🗑 DELETE
class DeleteTripLoading extends BusinessTripState {
  final int id;

  DeleteTripLoading({required this.id});
}

class DeleteTripSuccess extends BusinessTripState {
  Null get error => null;
}

class DeleteTripError extends BusinessTripState {
  final String? error;

  DeleteTripError({this.error});
}
