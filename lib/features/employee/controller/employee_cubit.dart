import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../data/repository/employee_repository.dart';
import 'employee_state.dart';

@injectable
class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository _repository;

  EmployeeCubit(this._repository) : super(EmployeeInitial());

  Future<void> getEmployeesByBranch(String branch) async {
    emit(EmployeeLoading());

    final result = await _repository.getEmployeesByBranch(branch);

    result.fold(
      (failure) => emit(EmployeeError(failure.message)),
      (employees) {
        if (employees.isEmpty) {
          emit(const EmployeeLoaded([]));
        } else {
          emit(EmployeeLoaded(employees));
        }
      },
    );
  }
}
