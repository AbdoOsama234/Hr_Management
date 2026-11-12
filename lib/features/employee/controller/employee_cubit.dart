import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/features/employee/data/models/branches_model.dart';
import 'package:hr_manegement/features/employee/data/models/employees_model.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart' as intl;

import '../data/models/attendance_request_model.dart';
import '../data/repository/employee_repository.dart';
import 'employee_state.dart';

@injectable
class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository _repository;

  static EmployeeCubit get(BuildContext context) =>
      context.read<EmployeeCubit>();

  EmployeeCubit(this._repository) : super(EmployeeInitial());

  List<BrancheModel> branches = [];
  int _currentPage = 1;
  bool _hasNext = true;

  Future<void> getAllBranches({bool loadMore = false}) async {
    if (state is GetAllBranchesLoading ||
        state is PaginationLoading ||
        (loadMore && !_hasNext)) {
      return;
    }

    if (loadMore) {
      emit(PaginationLoading());
    } else {
      branches.clear();
      _currentPage = 1;
      _hasNext = true;
      emit(GetAllBranchesLoading());
    }

    emit(GetAllBranchesLoading());

    _repository.getAllBranches(_currentPage).then((value) {
      value.fold(
        (l) {
          emit(GetAllBranchesError(error: l.message));
          print("get all brancheserror ${l.message}");
        },
        (r) {
          branches.addAll(r.result?.branches ?? []);
          _hasNext = r.result?.pagination?.hasNext ?? false;

          if (_hasNext) {
            _currentPage++;
          }

          emit(GetAllBranchesLoaded());
        },
      );
    });
  }

  ///
  List<UsersModel> users = [];

  Future<void> getAllUsers(String id, {bool loadMore = false}) async {
    if (state is GetAllUsersLoading ||
        state is PaginationLoading ||
        (loadMore && !_hasNext)) {
      return;
    }

    if (loadMore) {
      emit(PaginationLoading());
    } else {
      users.clear();
      _currentPage = 1;
      _hasNext = true;
      emit(GetAllUsersLoading());
    }

    _repository.getAllUsers(_currentPage, id).then((value) {
      value.fold(
        (l) {
          emit(GetAllUsersError(error: l.message));
        },
        (r) {
          users.addAll(r.result?.users ?? []);
          _hasNext = r.result?.pagination?.hasNext ?? false;

          if (_hasNext) {
            _currentPage++;
          }

          emit(GetAllUsersLoaded());
        },
      );
    });
  }

  // ================= Attendance =================

  /// Init Attendance Form
  void initAttendanceForm({
    String? employeeId,
    List<String>? employeeIds,
    String mode = 'check_in',
    String? time,
  }) {
    final now = DateTime.now();
    final ids = employeeIds ?? (employeeId != null ? [employeeId] : <String>[]);
    final defaultTime = time ?? (mode == 'check_out' ? '17:00' : '09:00');

    emit(
      AttendanceFormState(
        mode: mode,
        employeeIds: ids,
        dateFrom: now,
        dateTo: now,
        time: defaultTime,
        workingDaysOnly: false,
        overwrite: false,
        isSubmitting: false,
        error: null,
        isSuccess: false,
      ),
    );
  }

  /// Update Mode (check_in / check_out)
  void updateAttendanceMode(String mode) {
    if (state is! AttendanceFormState) return;

    final current = state as AttendanceFormState;
    String newTime = current.time;
    if (mode == 'check_out' && current.time == '09:00') {
      newTime = '17:00';
    } else if (mode == 'check_in' && current.time == '17:00') {
      newTime = '09:00';
    }

    emit(current.copyWith(mode: mode, time: newTime));
  }

  /// Update Selected Employees
  void updateAttendanceEmployees(List<String> ids) {
    if (state is! AttendanceFormState) return;

    emit((state as AttendanceFormState).copyWith(employeeIds: ids));
  }

  /// Update Date From
  void updateAttendanceDateFrom(DateTime date) {
    if (state is! AttendanceFormState) return;

    emit((state as AttendanceFormState).copyWith(dateFrom: date));
  }

  /// Update Date To
  void updateAttendanceDateTo(DateTime date) {
    if (state is! AttendanceFormState) return;

    emit((state as AttendanceFormState).copyWith(dateTo: date));
  }

  /// Update Attendance Time
  void updateAttendanceTime(String time) {
    if (state is! AttendanceFormState) return;

    emit((state as AttendanceFormState).copyWith(time: time));
  }

  /// Update Working Days Only
  void updateWorkingDaysOnly(bool value) {
    if (state is! AttendanceFormState) return;

    emit((state as AttendanceFormState).copyWith(workingDaysOnly: value));
  }

  /// Update Overwrite
  void updateOverwrite(bool value) {
    if (state is! AttendanceFormState) return;

    emit((state as AttendanceFormState).copyWith(overwrite: value));
  }

  /// Submit Attendance
  Future<void> createAttendance() async {
    if (state is! AttendanceFormState) return;

    final current = state as AttendanceFormState;

    if (current.employeeIds.isEmpty) {
      emit(current.copyWith(error: 'select_employee_warning'.tr()));
      return;
    }

    if (current.dateFrom.isAfter(current.dateTo)) {
      emit(current.copyWith(error: 'First Date must be before end Date'.tr()));
      return;
    }

    emit(current.copyWith(isSubmitting: true, error: null, isSuccess: false));

    final request = AttendanceRequest(
      mode: current.mode,
      employeeIds: current.employeeIds,
      dateFrom: intl.DateFormat('yyyy-MM-dd').format(current.dateFrom),
      dateTo: intl.DateFormat('yyyy-MM-dd').format(current.dateTo),
      time: current.time,
      workingDaysOnly: current.workingDaysOnly,
      overwrite: current.overwrite,
    );

    final result = await _repository.createAttendance(request);

    result.fold(
      (failure) {
        emit(current.copyWith(isSubmitting: false, error: failure.message));
      },
      (response) {
        emit(current.copyWith(isSubmitting: false, isSuccess: true));
      },
    );
  }

  /// Reset form state back to GetAllUsersLoaded
  void resetAttendanceForm() {
    emit(GetAllUsersLoaded());
  }
}
