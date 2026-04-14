import '../data/models/employee_model.dart';

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



