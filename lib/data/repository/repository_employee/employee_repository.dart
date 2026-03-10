import 'dart:convert';
import 'package:hr_manegement/core/api_urls.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import '../../../core/network/error_handler.dart';
import '../../models/models_employee/EmployeeWalletModel.dart';
import '../../models/models_employee/GetEmployeeFlatByAqarRequestModel.dart';
import '../../models/models_employee/get_employee_flat_model.dart';
import '../../storage/remote/dio_helper/dio_helper.dart';

@injectable
class EmployeeRepository {
  late DioHelper dioRequest;

  EmployeeRepository({required this.dioRequest});

  Future<Either<FailureException, List<FlatInfoDetailsModel>>> getEmployeeFlat({
    required String employeeID,
  }) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.getEmployeeFlat,
        data: {'EmployeeID': employeeID},
      );

      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        if (result["message"] == "NoData") return const Right([]);
        GetEmployeeFlatModel getEmployeeFlatModel =
            GetEmployeeFlatModel.fromJson(result);
        return Right(getEmployeeFlatModel.data);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure("Something went wrong, please try again later.".tr()),
      );
    }
  }

  Future<Either<FailureException, EmployeeWalletModel>> getEmployeeWallet({
    required String employeeID,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.getEmployeeWallet,
        data: {"EmployeeID": employeeID},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        EmployeeWalletModel employeeWalletModel = EmployeeWalletModel.fromJson(
          result,
        );
        return Right(employeeWalletModel);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure("Something went wrong, please try again later.".tr()),
      );
    }
  }

  Future<Either<FailureException, List<FlatInfoDetailsModel>>>
  getEmployeeFlatByAqar({
    required GetEmployeeFlatByAqarRequestModel getEmployeeFlatByAqar,
  }) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.getEmployeeFlatByAqar,
        data: getEmployeeFlatByAqar.toJson(),
      );

      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        GetEmployeeFlatModel getEmployeeFlatModel =
            GetEmployeeFlatModel.fromJson(result);
        return Right(getEmployeeFlatModel.data);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure("Something went wrong, please try again later.".tr()),
      );
    }
  }
}
