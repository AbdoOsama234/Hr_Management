import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hr_manegement/features/employee/data/models/branches_model.dart';
import 'package:hr_manegement/features/employee/data/models/employees_model.dart';
import 'package:injectable/injectable.dart';
import 'package:hr_manegement/core/network/error_handler.dart';
import 'package:retrofit/http.dart';
import '../../../../core/api_urls.dart';
import '../../../../core/network/save_api.dart';
import '../../../../data/models/base_response.dart';
import '../datasource/employee_local_data_source.dart';
import '../models/employee_model.dart';
import 'package:retrofit/error_logger.dart';

part 'employee_repository.g.dart';

@RestApi(baseUrl: ApiUrls.baseApiUrl)
abstract class EmployeeServiceClient {
  factory EmployeeServiceClient(Dio dio, {String baseUrl}) = _EmployeeServiceClient;

  @GET(ApiUrls.allBranches)
  Future<BaseResponse<AllBranches>> getAllBranches(@Query('page') int page);

    @GET("${ApiUrls.allUsers}{id}")
    Future<BaseResponse<AllUsers>> getAllUsers(@Query('page') int page,@Path("id")String id);


}

@injectable
class EmployeeRepository {
  final EmployeeServiceClient _employeeServiceClient;
  final SafeApi _safeApi;

  EmployeeRepository(this._employeeServiceClient, this._safeApi);

  Future<Either<Failure, BaseResponse<AllBranches>>> getAllBranches(
      int page
      ) async {
    return await _safeApi.call(apiCall: _employeeServiceClient.getAllBranches(page));
  }

  Future<Either<Failure,BaseResponse<AllUsers>>>getAllUsers(int page,String id)async{
    return await _safeApi.call(apiCall: _employeeServiceClient.getAllUsers(page,id));
  }


}




