import 'dart:convert';
import 'dart:io';

import 'package:hr_manegement/core/network/error_handler.dart';
import 'package:hr_manegement/data/models/models_owner/FlatRentTypeModel.dart';
import 'package:hr_manegement/data/models/models_owner/FlatTypeModel.dart';
import 'package:hr_manegement/data/models/models_owner/SearchMostagerModel.dart';
import 'package:hr_manegement/data/models/models_owner/flat_model_request.dart';
import 'package:hr_manegement/data/models/models_owner/flat_rentals_model.dart';
import 'package:hr_manegement/data/models/models_owner/spec_by_type_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_urls.dart';
import '../../../../core/di/di.dart';
import '../../../models/models_owner/FlatWalletModel.dart';
import '../../../models/models_owner/RemoveEmpFromFlatRequestModel.dart';
import '../../../models/models_owner/StopRentalRequestModel.dart';
import '../../../models/models_owner/add_expense_request_model.dart';
import '../../../models/models_owner/add_rental_model.dart';
import '../../../models/models_owner/add_rental_request_model.dart';
import '../../../models/models_owner/emoloyee_model.dart';
import '../../../models/models_owner/getFlatWalletRequestModel.dart';
import '../../../models/models_owner/my_aqar_flat_model.dart';
import '../../../models/models_owner/update_rental_request_model.dart';
import '../../../storage/local/app_prefs.dart';
import '../../../storage/remote/dio_helper/dio_helper.dart';

@singleton
class FlatsRepo {
  final DioHelper dioRequest;

  FlatsRepo({required this.dioRequest});

  Future<Either<FailureException, List<AqarFlatInfo>>> getAqarFlat({
    required String aqarID,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getMyAqarFlat,
        data: {"AqarID": aqarID},
      );
      var result;
      if (response.data is String) {
        result = json.decode(response.data);
      } else {
        result = response.data;
      }
      MyAqarFlatModel myAqarFlatModel = MyAqarFlatModel.fromJson(result);
      return right(myAqarFlatModel.data!);
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

  Future<Either<FailureException, List<AqarFlatInfo>>> getMostagerFlats({
    required String phoneNumber,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getMostagerFlats,
        data: {"Phone": phoneNumber},
      );

      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        MyAqarFlatModel myAqarFlatModel = MyAqarFlatModel.fromJson(result);
        return Right(myAqarFlatModel.data ?? []);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      return const Right([]);
      // if (e is DioException) {
      //   return left(ServerFailure.fromDiorError(e));
      // }
      // return left(ServerFailure("Something went wrong. Please check your internet connection and try again.".tr()));
    }
  }

  Future<Either<FailureException, List<FlatTypeInfo>>> getFlatType({
    String? aqarID,
    String? aqarTypeID,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getFlatType,
        data: {
          if (aqarID != null) "AqarID": aqarID else "AqarTypeID": aqarTypeID,
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
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, List<SpecByTypeInfo>>> getSpecByType({
    required String flatTypesID,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getSpecByType,
        data: {"FlatTypesID": flatTypesID},
      );
      var result;
      if (response.data is String) {
        result = json.decode(response.data);
      } else {
        result = response.data;
      }
      SpecByTypeModel specByTypeModel = SpecByTypeModel.fromJson(result);
      return right(specByTypeModel.data!);
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

  Future<Either<FailureException, bool>> addFlat({
    required FlatModelRequest flatModelRequest,
    File? fileImage,
  }) async {
    try {
      MultipartFile? file;
      if (fileImage != null) {
        file = await MultipartFile.fromFile(
          fileImage.path,
          filename: fileImage.path.split("/").last,
        );
      }
      var response = await dioRequest.post(
        endpoint: ApiUrls.addFlat,
        data: {
          'AqarID': flatModelRequest.aqarID,
          'FlatNum': flatModelRequest.flatNum,
          'FlatTypesID': flatModelRequest.flatTypesID,
          'RentPrice': flatModelRequest.rentPrice,
          "Text": flatModelRequest.text,
          "RentType": flatModelRequest.rentType,
          "RealfloorsNum": flatModelRequest.numberOfFloars,
          if (file != null) 'FlatPhoto': file,
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

  Future<Either<FailureException, bool>> updateFlat({
    required FlatModelRequest flatModelRequest,
    File? fileImage,
  }) async {
    try {
      MultipartFile? file;
      if (fileImage != null) {
        file = await MultipartFile.fromFile(
          fileImage.path,
          filename: fileImage.path.split("/").last,
        );
      }
      var response = await dioRequest.post(
        endpoint: ApiUrls.updateFlat,
        data: {
          'FlatID': flatModelRequest.aqarID,
          "RentType": flatModelRequest.rentType,
          //'FlatNum': flatModelRequest.flatNum,
          //'FlatTypesID': flatModelRequest.flatTypesID,
          'RentPrice': flatModelRequest.rentPrice,
          //"RealfloorsNum":flatModelRequest.numberOfFloars,
          "Text": flatModelRequest.text,
          if (file != null) 'FlatPhoto': file,
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

  Future<Either<FailureException, bool>> deleteFlat({
    required String flatId,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.deleteFlat,
        data: {"FlatID": flatId},
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

  Future<Either<FailureException, List<FlatRentalsModel>>> getFlatRentals({
    required String flatId,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getFlatRentals,
        data: {"FlatID": flatId},
      );

      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        List<FlatRentalsModel> models = [];
        result["data"].forEach((element) {
          models.add(FlatRentalsModel.fromJson(element));
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

  Future<Either<FailureException, List<EmployeeModel>>> getFlatCurrentEmployee({
    required String flatID,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getFlatCurrentEmployee,
        data: {"FlatID": flatID},
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

  Future<Either<FailureException, List<EmployeeModel>>> getFlatEmployees({
    required String flatID,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getFlatEmployees,
        data: {"FlatID": flatID},
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

  Future<Either<FailureException, List<FlatWalletInfoModel>>> getFlatWallet({
    required GetFlatWalletRequestModel getFlatWalletRequestModel,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getFlatWallet,
        data: getFlatWalletRequestModel.toJson(),
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
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, List<FlatRentTypeInfoModel>>> getFlatRentType(
    String aqarID,
  ) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getFlatRentType,
        data: {"AqarID": aqarID},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        FlatRentTypeModel flatRentTypeModel = FlatRentTypeModel.fromJson(
          result,
        );
        return Right(flatRentTypeModel.data!);
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

  Future<Either<FailureException, MyAqarFlatModel>> getAllFlat() async {
    String? ownerID = getIt<AppPreferences>().loadUserData?.ownerID;
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getAllMyFlats,
        data: {"OwnerID": ownerID},
      );
      var result;
      if (response.data is String) {
        result = json.decode(response.data);
      } else {
        result = response.data;
      }
      MyAqarFlatModel myAqarFlatModel = MyAqarFlatModel.fromJson(result);
      return right(myAqarFlatModel);
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

  Future<Either<FailureException, AqarFlatInfo>> addRental({
    required AddRentalRequestModel addRentalModel,
  }) async {
    try {
      addRentalModel.ownerID =
          getIt<AppPreferences>().loadUserData?.ownerID ?? "";
      print("addRentalModel.ownerID  ${addRentalModel.ownerID}");
      final response = await dioRequest.post(
        endpoint: ApiUrls.addRental,
        data: addRentalModel.toJson(),
        // data: {
        //   'OwnerID': addRentalModel.ownerID,
        //   'FlatID':addRentalModel.flatID,
        //   'Phone':addRentalModel.phoneNumber,
        //   'UName':addRentalModel.uName,
        //   'RentType':addRentalModel.rentType,
        //   'Price':addRentalModel.price,
        //   'StartDate':addRentalModel.startDate,
        //   'Daysw':addRentalModel.numberOfDays
        // },
      );

      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        print("json.decode(response.data) : ${result.toString()}");
        AqarFlatInfo aqarFlatInfo = AqarFlatInfo.fromJson(result['data']);
        return Right(aqarFlatInfo);
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

  Future<Either<FailureException, bool>> stopRental({
    required StopRentalRequestModel stopRentalRequestModel,
  }) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrls.stopRental,
        data: stopRentalRequestModel.toJson(),
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
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, List<SearchMostagerInfoModel>>>
  searchMostager({required String search}) async {
    String? ownerID = getIt<AppPreferences>().loadUserData?.ownerID;
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.searchMostager,
        data: {"Search": search, "OwnerID": ownerID},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        SearchMostagerModel searchMostagerModel = SearchMostagerModel.fromJson(
          result,
        );
        return Right(searchMostagerModel.data ?? []);
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

  Future<Either<FailureException, bool>> updateMostager({
    required UpdateRentalRequestModel updateRentalRequestModel,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.updateRental,
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
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, bool>> removeEmpFromFlat({
    required RemoveEmpFromFlatRequestModel removeEmpFromFlat,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.removeEmpFromFlat,
        data: removeEmpFromFlat.toJson(),
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
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, bool>> addRentalPrice({
    required AddRentalPriceRequestModel addRentalPriceRequestModel,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.addRentalPrice,
        data: addRentalPriceRequestModel.toJson(),
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
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, bool>> makeItSyana({
    required String flatId,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.makeItSyana,
        data: {"FlatID": flatId},
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
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, bool>> addExpense({
    required AddExpenseRequestModel req,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.addMasrof,
        data: req.toJson(),
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
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }
}
