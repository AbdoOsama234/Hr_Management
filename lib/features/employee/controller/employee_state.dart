import '../data/models/employee_model.dart';

abstract class EmployeeState {
  const EmployeeState();
}

/// 👥 Employee List States
class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<EmployeeModel> employees;

  final DateTime? selectedDate;
  final String? notes;
  final bool isSubmitting;

  /// 👇 مهم جدًا
  final bool isSuccess;

  const EmployeeLoaded(
      this.employees, {
        this.selectedDate,
        this.notes,
        this.isSubmitting = false,
        this.isSuccess = false,
      });

  EmployeeLoaded copyWith({
    List<EmployeeModel>? employees,
    DateTime? selectedDate,
    String? notes,
    bool? isSubmitting,
    bool? isSuccess,
  }) {
    return EmployeeLoaded(
      employees ?? this.employees,
      selectedDate: selectedDate ?? this.selectedDate,
      notes: notes ?? this.notes,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? false, // 👈 reset
    );
  }
}

class EmployeeError extends EmployeeState {
  final String message;
  const EmployeeError(this.message);
}