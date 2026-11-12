abstract class EmployeeState {
  const EmployeeState();
}

/// 👥 Employee List States
class EmployeeInitial extends EmployeeState {}

class GetAllBranchesLoading extends EmployeeState {}

class GetAllBranchesLoaded extends EmployeeState {}

class GetAllBranchesError extends EmployeeState {
  final String error;
  GetAllBranchesError({required this.error});
}

class PaginationLoading extends EmployeeState {}

///Users State

class GetAllUsersLoading extends EmployeeState {}

class GetAllUsersLoaded extends EmployeeState {}

class GetAllUsersError extends EmployeeState {
  final String error;
  GetAllUsersError({required this.error});
}

// class EmployeeLoaded extends EmployeeState {
//   final DateTime selectedDate;
//   final String notes;
//   final bool isSubmitting;

//   const EmployeeLoaded({
//     required this.selectedDate,
//     this.notes = "",
//     this.isSubmitting = false,
//   });

//   EmployeeLoaded copyWith({
//     DateTime? selectedDate,
//     String? notes,
//     bool? isSubmitting,
//   }) {
//     return EmployeeLoaded(
//       selectedDate: selectedDate ?? this.selectedDate,
//       notes: notes ?? this.notes,
//       isSubmitting: isSubmitting ?? this.isSubmitting,
//     );
//   }
// }

class AttendanceFormState extends EmployeeState {
  final String mode;
  final List<String> employeeIds;
  final DateTime dateFrom;
  final DateTime dateTo;
  final String time;
  final bool workingDaysOnly;
  final bool overwrite;
  final bool isSubmitting;
  final String? error;
  final bool isSuccess;

  const AttendanceFormState({
    this.mode = 'check_in',
    this.employeeIds = const [],
    required this.dateFrom,
    required this.dateTo,
    this.time = '09:00',
    this.workingDaysOnly = false,
    this.overwrite = false,
    this.isSubmitting = false,
    this.error,
    this.isSuccess = false,
  });

  AttendanceFormState copyWith({
    String? mode,
    List<String>? employeeIds,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? time,
    bool? workingDaysOnly,
    bool? overwrite,
    bool? isSubmitting,
    String? error,
    bool? isSuccess,
  }) {
    return AttendanceFormState(
      mode: mode ?? this.mode,
      employeeIds: employeeIds ?? this.employeeIds,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      time: time ?? this.time,
      workingDaysOnly: workingDaysOnly ?? this.workingDaysOnly,
      overwrite: overwrite ?? this.overwrite,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
