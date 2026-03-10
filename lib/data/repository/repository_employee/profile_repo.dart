import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api_urls.dart';
import '../../../core/network/error_handler.dart';
import '../../models/models_employee/TermsModel.dart';
import '../../models/models_employee/employee_update_request_model.dart';
import '../../models/models_employee/get_employee_model.dart';
import '../../storage/remote/dio_helper/dio_helper.dart';

@singleton
class ProfileRepo {
  final DioHelper dioRequest;

  ProfileRepo({required this.dioRequest});

  Future<Either<FailureException, EmployeeInfoModel>> updateProfileDate(
      {required EmployeeUpdateRequestModel employeeUpdateRequestModel}) async {
    try {
      MultipartFile? file;
      if (employeeUpdateRequestModel.employeePhoto != null) {
        file = await MultipartFile.fromFile(
            employeeUpdateRequestModel.employeePhoto!.path,
            filename:
                employeeUpdateRequestModel.employeePhoto!.path.split("/").last);
      }
      employeeUpdateRequestModel.printData();
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.updateProfile,
        data: {
          'EmpPhone': employeeUpdateRequestModel.empPhone,
          'EmpKey': employeeUpdateRequestModel.empKey,
          'EmployeeID': employeeUpdateRequestModel.employeeID,
          if (file != null) "EmployeePhoto": file
        },
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        GetEmployeeModel getEmployeeModel = GetEmployeeModel.fromJson(result);
        return Right(getEmployeeModel.data!);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure("Something went wrong, please try again later.".tr()));
    }
  }

  Future<Either<FailureException, TermsInfoModel>> getTerms() async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.getTerms,
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        TermsModel termsModel = TermsModel.fromJson(result);
        return Right(termsModel.data!);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure("Something went wrong, please try again later.".tr()));
    }
  }
}
