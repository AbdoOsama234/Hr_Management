import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/features/employee/data/models/branches_model.dart';
import 'package:hr_manegement/features/employee/data/models/employees_model.dart';
import 'package:injectable/injectable.dart';
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
    ///
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

  /// 👥 Fetch employees
  // Future<void> getEmployeesByBranch(String branch) async {
  //   emit(EmployeeLoading());
  //
  //   final result = await _repository.getEmployeesByBranch(branch);
  //
  //   result.fold(
  //         (failure) => emit(EmployeeError(failure.message)),
  //         (employees) => emit(EmployeeLoaded(employees)),
  //   );
  // }

  /// 🟢 Init Attendance Form
  // void initAttendanceForm() {
  //   if (state is EmployeeLoaded) {
  //     final current = state as EmployeeLoaded;
  //
  //     emit(
  //       current.copyWith(
  //         selectedDate: DateTime.now(),
  //         notes: "",
  //         isSubmitting: false,
  //       ),
  //     );
  //   }
  // }
  //
  // /// 📅 Change Date
  // void changeDate(DateTime date) {
  //   if (state is EmployeeLoaded) {
  //     final current = state as EmployeeLoaded;
  //
  //     emit(current.copyWith(selectedDate: date));
  //   }
  // }
  //
  // /// 📝 Change Notes
  // void changeNotes(String notes) {
  //   if (state is EmployeeLoaded) {
  //     final current = state as EmployeeLoaded;
  //
  //     emit(current.copyWith(notes: notes));
  //   }
  // }
  //
  // /// 🚀 Submit
  // Future<void> submitAttendance(int employeeId) async {
  //   if (state is! EmployeeLoaded) return;
  //
  //   final current = state as EmployeeLoaded;
  //
  //   /// loading
  //   emit(current.copyWith(isSubmitting: true));
  //
  //   try {
  //     await Future.delayed(const Duration(milliseconds: 800));
  //
  //     /// success → رجع نفس state بدون loading
  //     /// ✅ هنا الحل الحقيقي
  //     emit(current.copyWith(isSubmitting: false, isSuccess: true));
  //   } catch (e) {
  //     emit(current.copyWith(isSubmitting: false, isSuccess: false));
  //   }
  // }
}
