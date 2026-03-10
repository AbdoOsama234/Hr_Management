import 'dart:convert';
import 'dart:io';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/data/models/models_owner/AddEmployeeToAqarRequestModel.dart';
import 'package:hr_manegement/data/models/models_owner/CheckPromoReqModel.dart';
import 'package:hr_manegement/data/models/models_owner/GetAllMyBillsModel.dart';
import 'package:hr_manegement/data/models/models_owner/GetAqarTypeModel.dart';
import 'package:hr_manegement/data/models/models_owner/GetHomeStatsModel.dart';
import 'package:hr_manegement/data/models/models_owner/RemoveEmpFromAqarRequestModel.dart';
import 'package:hr_manegement/data/models/models_owner/UpdateEshterakReqModel.dart';
import 'package:hr_manegement/data/storage/local/app_prefs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/api_urls.dart';
import '../../../../core/network/error_handler.dart';
import '../../../models/models_owner/AqarEmployeesModel.dart';
import '../../../models/models_owner/AqarPricesModel.dart';
import '../../../models/models_owner/aqar_model.dart';
import '../../../models/models_owner/get_aqar_bakat_model.dart';
import '../../../models/models_owner/my_aqars_model.dart';
import '../../../models/models_owner/my_areas_model.dart';
import '../../../models/models_owner/my_gover_model.dart';
import '../../../storage/remote/dio_helper/dio_helper.dart';

@singleton
class RealEstateRepo {
  final DioHelper dioRequest;

  RealEstateRepo({required this.dioRequest});

  Future<Either<FailureException, List<AreaData>>> getMyAreas() async {
    try {
      final response = await dioRequest.post(endpoint: ApiUrls.getMyAreas);
      final dynamic rawData = response.data is String
          ? json.decode(response.data)
          : response.data;

      final myAreasModel = MyAreasModel.fromJson(rawData);

      if (myAreasModel.data != null) {
        return right(myAreasModel.data!);
      } else {
        return right([]);
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

  Future<Either<FailureException, List<GoverDataModel>>> getMyGover({
    required String areaID,
  }) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrls.getMyGover,
        data: {"AreaID": areaID},
      );
      final dynamic rawData = response.data is String
          ? json.decode(response.data)
          : response.data;

      final myGoverModel = MyGoverModel.fromJson(rawData);

      if (myGoverModel.data != null) {
        return right(myGoverModel.data!);
      } else {
        return right([]);
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

  Future<Either<FailureException, AqarInfo>> addAqar({
    required AqarInfo aqarInfo,
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
      final response = await dioRequest.post(
        endpoint: ApiUrls.addAqar,
        data: {
          'AqarTypeID': aqarInfo.aqarTypeID,
          'AqarName': aqarInfo.aqarName,
          'OwnerID': getIt<AppPreferences>().loadUserData?.ownerID ?? "",
          'FloarNum': aqarInfo.floarNum,
          'AreaID': aqarInfo.areaID,
          'GoverID': aqarInfo.goverID,
          'AqarLat': aqarInfo.aqarLat,
          'AqarLongt': aqarInfo.aqarLongt,
          'RealfloorsNum': aqarInfo.realfloorsNum,
          'Price': aqarInfo.price,
          'NumType': aqarInfo.numType,
          'BakatID': aqarInfo.bakatID,
          if (file != null) 'AqarPhoto': file,
        },
      );
      final dynamic rawData = response.data is String
          ? json.decode(response.data)
          : response.data;

      final aqarModel = AqarModel.fromJson(rawData);

      if (aqarModel.data != null) {
        return right(aqarModel.data!);
      } else {
        return right(AqarInfo());
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure("Somthing "));
    }
  }

  Future<Either<FailureException, List<AqarInfo>>> getAqars({
    required String ownerID,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getAqars,
        data: {"OwnerID": getIt<AppPreferences>().loadUserData?.ownerID ?? ""},
      );
      var result;
      print("response.data : ${response.data}");
      if (response.data is String) {
        result = json.decode(response.data);
      } else {
        result = response.data;
      }
      MyAqarsModel myAqarsModel = MyAqarsModel.fromJson(result);
      print("result = : $result");
      print("onBoardingModel ${myAqarsModel.data?.length}");
      return right(myAqarsModel.data!);
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

  Future<Either<FailureException, bool>> deleteAqar({
    required String aqarID,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.deleteAqar,
        data: {"AqarID": aqarID},
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

  Future<Either<FailureException, bool>> editAqar({
    required AqarInfo aqarInfo,
    File? fileImage,
    required String token,
  }) async {
    try {
      MultipartFile? file;
      if (fileImage != null) {
        file = await MultipartFile.fromFile(
          fileImage.path,
          filename: fileImage.path.split("/").last,
        );
      }
      var formData = {
        'AqarName': aqarInfo.aqarName,
        'OwnerID': aqarInfo.ownerID,
        'AqarID': aqarInfo.aqarID,
        'FloarNum': aqarInfo.floarNum,
        'AreaID': aqarInfo.areaID,
        'GoverID': aqarInfo.goverID,
        'AqarLat': aqarInfo.aqarLat,
        'AqarLongt': aqarInfo.aqarLongt,
        if (file != null) 'AqarPhoto': file,
      };
      print("formData = FormData.fromMap : $formData");
      var response = await dioRequest.post(
        endpoint: ApiUrls.editAqar,
        data: formData,
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

  Future<Either<FailureException, List<AqarInfo>>> getMyAqarsByName({
    required String aqarName,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getMyAqarsByName,
        data: {
          "OwnerID": getIt<AppPreferences>().loadUserData?.ownerID ?? "",
          "AqarName": aqarName,
        },
      );
      var result;
      print("response.data : ${response.data}");
      if (response.data is String) {
        result = json.decode(response.data);
      } else {
        result = response.data;
      }
      MyAqarsModel myAqarsModel = MyAqarsModel.fromJson(result);
      print("result = : $result");
      print("onBoardingModel ${myAqarsModel.data?.length}");
      return right(myAqarsModel.data!);
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

  Future<Either<FailureException, bool>> addEmployeeToAqar({
    required AddEmployeeToAqarRequestModel addEmployeeToAqarRequestModel,
  }) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.addEmployeeToAqar,
        data: addEmployeeToAqarRequestModel.toJson(),
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

  Future<Either<FailureException, List<AqarEmployeesInfoModel>?>>
  getAqarEmployees({required String aqarID}) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getAqarEmployees,
        data: {"AqarID": aqarID},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        AqarEmployeesModel aqarEmployeesModel = AqarEmployeesModel.fromJson(
          result,
        );
        return Right(aqarEmployeesModel.data);
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

  Future<Either<FailureException, AqarPricesInfoModel?>> getAqarPrices() async {
    try {
      var response = await dioRequest.post(endpoint: ApiUrls.getAqarPrices);
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        AqarPricesModel aqarPricesModel = AqarPricesModel.fromJson(result);
        return Right(aqarPricesModel.data);
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

  Future<Either<FailureException, List<AqarTypeInfo>?>> getAqarTypes() async {
    try {
      var response = await dioRequest.post(endpoint: ApiUrls.getAqarType);
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        GetAqarTypeModel getAqarTypeModel = GetAqarTypeModel.fromJson(result);
        return Right(getAqarTypeModel.data);
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

  Future<Either<FailureException, bool>> removeEmpFromAqar(
    RemoveEmpFromAqarRequestModel removeEmpFromAqarRequestModel,
  ) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.removeEmpFromAqar,
        data: removeEmpFromAqarRequestModel.toJson(),
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

  Future<Either<FailureException, GetHomeStatsInfoModel?>>
  getHomeStats() async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getHomeStats,
        data: {"OwnerID": getIt<AppPreferences>().loadUserData?.ownerID ?? ""},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        GetHomeStatsModel getHomeStatsModel = GetHomeStatsModel.fromJson(
          result,
        );
        return Right(getHomeStatsModel.data);
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

  Future<Either<FailureException, List<AqarBakaInfoModel>?>> getAqarBakat(
    String numType,
  ) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getAqarBakat,
        data: {
          "NumType": numType,
          "OwnerID": getIt<AppPreferences>().loadUserData?.ownerID ?? "",
        },
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        GetAqarBakatModel getAqarBakatModel = GetAqarBakatModel.fromJson(
          result,
        );
        return Right(getAqarBakatModel.data);
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

  Future<Either<FailureException, List<BillInfoModel>?>> getAllMyBills() async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getAllMyBills,
        data: {"OwnerID": getIt<AppPreferences>().loadUserData?.ownerID ?? ""},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        GetAllMyBillsModel getAllMyBillsModel = GetAllMyBillsModel.fromJson(
          result,
        );
        return Right(getAllMyBillsModel.data);
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

  Future<Either<FailureException, bool?>> updateEshterak(
    UpdateEshterakReqModel updateEshterakReqModel,
  ) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.updateEshterak,
        data: updateEshterakReqModel.toJson(),
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

  Future<Either<FailureException, String?>> checkPromo(
    CheckPromoModel checkPromoModel,
  ) async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.checkPromo,
        data: checkPromoModel.toJson(),
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return Right(result['data']);
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

  Future<Either<FailureException, String?>> canPay() async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.canPay,
        data: {"OwnerID": getIt<AppPreferences>().loadUserData?.ownerID ?? ""},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return Right(
          (result['data'] != null && result['data']['Pay'] != null)
              ? result['data']['Pay']
              : null,
        );
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
