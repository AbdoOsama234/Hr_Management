import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hr_manegement/core/network/error_handler.dart';
import '../datasource/employee_local_data_source.dart';
import '../models/employee_model.dart';

abstract class EmployeeRepository {
  Future<Either<FailureException, List<EmployeeModel>>> getEmployeesByBranch(String branch);
}

@injectable
class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeLocalDataSource _localDataSource;

  EmployeeRepositoryImpl(this._localDataSource);

  @override
  Future<Either<FailureException, List<EmployeeModel>>> getEmployeesByBranch(String branch) async {
    try {
      final allEmployees = await _localDataSource.getEmployees();
      
      /// 🔍 Filter employees by branch name
      final filteredEmployees = allEmployees.where((e) => e.branch == branch).toList();
      
      return Right(filteredEmployees);
    } catch (e) {
      return Left(ServerFailure("Failed to load employees for $branch"));
    }
  }
}
