abstract class MyMissionState {}

class MyMissionInitial extends MyMissionState {}

/// 📥 GET ALL
class GetAllMissionsLoading extends MyMissionState {}

class GetAllMissionsLoaded extends MyMissionState {}

class GetAllMissionsError extends MyMissionState {
  final String? error;

  GetAllMissionsError({this.error});
}

/// 🔄 Pagination
class PaginationLoading extends MyMissionState {}

/// 📥 GET DETAILS
class GetMissionDetailsLoading extends MyMissionState {}

class GetMissionDetailsLoaded extends MyMissionState {}

class GetMissionDetailsError extends MyMissionState {
  final String? error;

  GetMissionDetailsError({this.error});
}

/// 🔄 UPDATE
class UpdateMissionLoading extends MyMissionState {
  final int id;

  UpdateMissionLoading({required this.id});
}

class UpdateMissionSuccess extends MyMissionState {}

class UpdateMissionError extends MyMissionState {
  final String? error;

  UpdateMissionError({this.error});
}
