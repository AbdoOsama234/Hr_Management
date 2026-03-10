part of 'main_screen_cubit.dart';

@immutable
sealed class MainScreenState {}

final class MainScreenInitial extends MainScreenState {}

final class MainScreenLoading extends MainScreenState {}

final class MainScreenError extends MainScreenState {
  final String message;
  MainScreenError(this.message);
}

final class MainScreenLoaded extends MainScreenState {
  final EmployeeDashboard dashboard;

  MainScreenLoaded({required this.dashboard});

  double get lateHoursRemaining =>
      dashboard.lateHoursAllowed - dashboard.lateHoursUsed;
  double get lateHoursProgress =>
      dashboard.lateHoursUsed / dashboard.lateHoursAllowed;
}
