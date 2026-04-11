  import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
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

   List<BrancheModel> branches=[];

    Future<void>getAllBranches()async{
      branches = [];
      emit(GetAllBranchesLoading());
      _repository.getAllBranches().then((value) {
        value.fold(
              (l) {
            emit(GetAllBranchesError(error: l.message));
            print("get all brancheserror ${l.message}");
          },
              (r) {
                branches = r.result?.branches ?? [];
            print("get all bbranches ${branches.length}");
            emit(GetAllBranchesLoaded());
          },
        );
      });

    }
    List<UsersModel>users=[];
    Future<void>getAllUsers(String id)async{
      users=[];
      emit(GetAllUsersLoading());
      _repository.getAllUsers(id).then((value){
        value.fold(
            (l){
              emit(GetAllUsersError(error: l.message));
              print("get all Userserror ${l.message}");


            },
            (r){
          users= r.result?.users??[];
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
  void initAttendanceForm() {
    if (state is EmployeeLoaded) {
      final current = state as EmployeeLoaded;

      emit(
        current.copyWith(
          selectedDate: DateTime.now(),
          notes: "",
          isSubmitting: false,
        ),
      );
    }
  }

  /// 📅 Change Date
  void changeDate(DateTime date) {
    if (state is EmployeeLoaded) {
      final current = state as EmployeeLoaded;

      emit(current.copyWith(selectedDate: date));
    }
  }

  /// 📝 Change Notes
  void changeNotes(String notes) {
    if (state is EmployeeLoaded) {
      final current = state as EmployeeLoaded;

      emit(current.copyWith(notes: notes));
    }
  }

  /// 🚀 Submit
  Future<void> submitAttendance(int employeeId) async {
    if (state is! EmployeeLoaded) return;

    final current = state as EmployeeLoaded;

    /// loading
    emit(current.copyWith(isSubmitting: true));

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      /// success → رجع نفس state بدون loading
      /// ✅ هنا الحل الحقيقي
      emit(current.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(current.copyWith(isSubmitting: false, isSuccess: false));
    }
  }
}
