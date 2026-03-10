import 'dart:convert';

import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/data/models/models_owner/CollectMoneyFromEmployeeRequestModel.dart';
import 'package:hr_manegement/data/models/models_owner/add_employee_model.dart';
import 'package:hr_manegement/data/models/models_owner/emoloyee_model.dart';
import 'package:hr_manegement/data/models/models_owner/my_aqar_flat_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_urls.dart';
import '../../../../core/network/error_handler.dart';
import '../../../models/models_owner/CollectMoneyFromEmployeeModel.dart';
import '../../../models/models_owner/EmployeeWalletModel.dart';
import '../../../models/models_owner/EmployeeWalletTotalModel.dart';
import '../../../models/models_owner/getEmployeeWalletRequestModel.dart';
import '../../../storage/local/app_prefs.dart';
import '../../../storage/remote/dio_helper/dio_helper.dart';

@singleton
class EmployeesRepo {
  final DioHelper dioRequest;

  EmployeesRepo({required this.dioRequest});

  Future<Either<FailureException, bool>> addEmployee({
    required AddEmployeeModel addEmployeeModel,
  }) async {
    try {
      MultipartFile? file;
      if (addEmployeeModel.employeePhoto != null) {
        file = await MultipartFile.fromFile(
          addEmployeeModel.employeePhoto!.path,
          filename: addEmployeeModel.employeePhoto!.path.split("/").last,
        );
      }
      var response = await dioRequest.post(
        endpoint: ApiUrls.addEmployee,
        data: {
          'EmployeeName': addEmployeeModel.employeeName,
          'EmpKey': addEmployeeModel.phoneNumberKey,
          'EmpPhone': addEmployeeModel.phoneNumber,
          'OwnerID': getIt<AppPreferences>().loadUserData?.ownerID ?? "",
          if (file != null) 'EmployeePhoto': file,
        },
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return Right(result['success']);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, List<EmployeeModel>>> getMyEmployees() async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getMyEmployees,
        data: {"OwnerID": getIt<AppPreferences>().loadUserData?.ownerID ?? ""},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        List<EmployeeModel> models = [];
        result["data"].forEach((element) {
          models.add(EmployeeModel.fromJson(element));
        });
        return Right(models);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, List<EmployeeModel>>> getMyEmployeesByName({
    required String empName,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getMyEmployeesByName,
        data: {
          "OwnerID": getIt<AppPreferences>().loadUserData?.ownerID ?? "",
          "EmployeeName": empName,
        },
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        List<EmployeeModel> models = [];
        result["data"].forEach((element) {
          models.add(EmployeeModel.fromJson(element));
        });
        return Right(models);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, bool>> changeEmpStatus({
    required String employeeID,
    required String employeeStatus,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.changeEmpStatus,
        data: {"EmployeeID": employeeID, "EmployeeStatus": employeeStatus},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return Right(result['success']);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, bool>> changeStopingStatus({
    required String employeeID,
    required String canDeleteMost,
    required String canUpdateMost,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.changeEmpSalahyat,
        data: {
          "EmployeeID": employeeID,
          "CanDeleteMost": canDeleteMost,
          "CanUpdateMost": canUpdateMost,
        },
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return Right(result['success']);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, bool>> changeEditStatus({
    required String employeeID,
    required String canUpdateMost,
    required String canDeleteMost,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.changeEmpSalahyat,
        data: {
          "EmployeeID": employeeID,
          "CanUpdateMost": canUpdateMost,
          "CanDeleteMost": canDeleteMost,
        },
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return Right(result['success']);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, bool>> addEmployeeToFlat({
    required String employeeID,
    required String flatID,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.addEmployeeToFlat,
        data: {"EmployeeID": employeeID, "FlatID": flatID},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return Right(result['success']);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, List<AqarFlatInfo>>> getEmployeeFlat({
    required String id,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getEmployeeFlat,
        data: {"EmployeeID": id},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        List<AqarFlatInfo> models = [];
        result["data"].forEach((element) {
          models.add(AqarFlatInfo.fromJson(element));
        });
        return Right(models);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, List<EmployeeWalletInfoModel>>>
  getEmployeeWallet({
    required GetEmployeeWalletRequestModel getEmployeeWalletRequestModel,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getEmployeeWallet,
        data: getEmployeeWalletRequestModel.toJson(),
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        EmployeeWalletModel employeeWalletModel = EmployeeWalletModel.fromJson(
          result,
        );
        return Right(employeeWalletModel.data!);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, String>> getEmployeeWalletTotal() async {
    try {
      String? ownerID = getIt<AppPreferences>().loadUserData?.ownerID;
      var response = await dioRequest.post(
        endpoint: ApiUrls.getEmployeeWalletTotal,
        data: {"OwnerID": ownerID},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        EmployeeWalletTotalModel employeeWalletModel =
            EmployeeWalletTotalModel.fromJson(result);
        return Right(employeeWalletModel.data ?? "0");
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, String>> collectMoneyFromEmployee({
    required CollectMoneyFromEmployeeRequestModel
    collectMoneyFromEmployeeRequestModel,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.collectMoneyFromEmployee,
        data: collectMoneyFromEmployeeRequestModel.toJson(),
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        CollectMoneyFromEmployeeModel collectMoneyFromEmployeeModel =
            CollectMoneyFromEmployeeModel.fromJson(result);
        return Right(collectMoneyFromEmployeeModel.message!);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }
}
