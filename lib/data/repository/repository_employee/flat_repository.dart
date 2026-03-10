import 'dart:convert';
import 'package:hr_manegement/core/api_urls.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../core/di/di.dart';
import '../../../core/network/error_handler.dart';
import '../../models/models_employee/FlatRentTypeModel.dart';
import '../../models/models_employee/FlatTypeModel.dart';
import '../../models/models_employee/FlatWalletModel.dart';
import '../../models/models_employee/FlatWalletRequestModel.dart';
import '../../models/models_employee/SearchMostagerModel.dart';
import '../../models/models_employee/StopRentalRequestModel.dart';
import '../../models/models_employee/add_rental_model.dart';
import '../../models/models_employee/add_rental_price_model.dart';
import '../../models/models_employee/get_employee_flat_model.dart';
import '../../models/models_employee/get_flat_rentals_model.dart';
import '../../models/models_employee/update_rental_request_model.dart';
import '../../storage/local/app_prefs.dart';
import '../../storage/remote/dio_helper/dio_helper.dart';

@injectable
class FlatRepository {
  late DioHelper dioRequest;
  FlatRepository({required this.dioRequest});

  Future<Either<FailureException, List<FlatRentalInfoModel>>> getFlatRentals({
    required String flatID,
  }) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.getFlatRentals,
        data: {'FlatID': flatID},
      );

      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        if (result["message"] == "NoData") return const Right([]);
        GetFlatRentalsModel getEmployeeFlatModel = GetFlatRentalsModel.fromJson(
          result,
        );
        return Right(getEmployeeFlatModel.data!);
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

  Future<Either<FailureException, bool>> addRental({
    required AddRentalRequestModel addRentalModel,
  }) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.addRental,
        data: addRentalModel.toJson(),
        // data: {
        //   'EmployeeID': addRentalModel.employeeID,
        //   'FlatID': addRentalModel.flatID,
        //   'Phone': addRentalModel.phoneNumber,
        //   'UName': addRentalModel.uName,
        //   'RentType': addRentalModel.rentType,
        //   'Price': addRentalModel.price
        // },
      );

      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        print("json.decode(response.data) : ${result.toString()}");
        return const Right(true);
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

  Future<Either<FailureException, bool>> addRentalPrice({
    required AddRentalPriceRequestModel addRentalPriceRequestModel,
  }) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.addRentalPrice,
        data: {
          'EmployeeID': addRentalPriceRequestModel.employeeID,
          'FlatID': addRentalPriceRequestModel.flatID,
          'Price': addRentalPriceRequestModel.price,
        },
      );

      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return const Right(true);
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

  Future<Either<FailureException, bool>> stopRental({
    required StopRentalRequestModel stopRentalRequestModel,
  }) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.stopRental,
        data: {'FlatAndRentalID': stopRentalRequestModel.flatAndRentalID},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return const Right(true);
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

  Future<Either<FailureException, List<FlatRentTypeInfoModel>>>
  getFlatRentType() async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.getFlatRentType,
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        FlatRentTypeModel flatRentTypeModel = FlatRentTypeModel.fromJson(
          result,
        );
        return Right(flatRentTypeModel.data ?? []);
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

  Future<Either<FailureException, List<FlatWalletInfoModel>>> getFlatWallet({
    required FlatWalletRequestModel flatWalletRequestModel,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.getFlatWallet,
        data: flatWalletRequestModel.toJson(),
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        FlatWalletModel flatWalletModel = FlatWalletModel.fromJson(result);
        return Right(flatWalletModel.data!);
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

  Future<Either<FailureException, List<FlatTypeInfo>>> getFlatType() async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.getFlatType,
        data: {
          "OwnerID": getIt<AppPreferences>().loadEmployeeData?.ownerID ?? "",
        },
      );
      var result;
      if (response.data is String) {
        result = json.decode(response.data);
      } else {
        result = response.data;
      }
      FlatTypeModel flatTypeModel = FlatTypeModel.fromJson(result);
      return right(flatTypeModel.data!);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure("Something went wrong, please try again later.".tr()),
      );
    }
  }

  Future<Either<FailureException, String>> sendMessageToRental({
    required String phoneNumber,
    required String message,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.sendMessage,
        data: {"PhoneNumber": phoneNumber, "Message": message},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return Right(result['message']);
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
  getMostagerFlats({required String phoneNumber}) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.getMostagerFlats,
        data: {'Phone': phoneNumber},
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

  Future<Either<FailureException, List<SearchMostagerInfoModel>>>
  searchMostager({required String phoneNumber}) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.searchMostager,
        data: {
          'EmployeeID':
              getIt<AppPreferences>().loadEmployeeData?.employeeID ?? "",
          'Search': phoneNumber,
        },
      );

      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        if (result["message"] == "NoData") return const Right([]);
        SearchMostagerModel searchMostagerModel = SearchMostagerModel.fromJson(
          result,
        );
        return Right(searchMostagerModel.data!);
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

  Future<Either<FailureException, bool>> updateMostager({
    required UpdateRentalRequestModel updateRentalRequestModel,
  }) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.updateRental,
        data: updateRentalRequestModel.toJson(),
      );

      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return const Right(true);
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

  Future<Either<FailureException, bool>> makeItSyana({
    required String flatID,
  }) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.makeItSyana,
        data: {"FlatID": flatID},
      );

      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return const Right(true);
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
