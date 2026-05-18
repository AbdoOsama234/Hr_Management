import '../data/models/attendance_model.dart';
import '../data/models/employee_dashboard.dart';

abstract class MainState {}

class MainInitial extends MainState {}

/// 📥 GET ATTENDANCE
class GetAttendanceLoading extends MainState {}

class GetAttendanceSuccess extends MainState {
  final AttendanceModel? attendance;

  GetAttendanceSuccess({this.attendance});
}

class GetAttendanceError extends MainState {
  final String? error;

  GetAttendanceError({this.error});
}

/// 📥 DASHBOARD (Keep existing)
class MainScreenLoading extends MainState {}

class MainScreenLoaded extends MainState {
  final EmployeeDashboard dashboard;

  MainScreenLoaded({required this.dashboard});

  double get lateHoursRemaining =>
      dashboard.lateHoursAllowed - dashboard.lateHoursUsed;
  double get lateHoursProgress =>
      dashboard.lateHoursUsed / dashboard.lateHoursAllowed;
}

class MainScreenError extends MainState {
  final String message;
  MainScreenError(this.message);
}
