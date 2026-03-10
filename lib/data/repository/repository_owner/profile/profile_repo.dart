import 'dart:convert';
import 'dart:io';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/data/models/models_owner/GetOwnerInfoModel.dart';
import 'package:hr_manegement/data/models/models_owner/TermsModel.dart';
import 'package:hr_manegement/data/storage/local/app_prefs.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api_urls.dart';
import '../../../../core/network/error_handler.dart';
import '../../../models/models_owner/RefuseResonsModel.dart';
import '../../../models/models_owner/owner_info.dart';
import '../../../models/models_owner/upload_file_request_model.dart';
import '../../../storage/remote/dio_helper/dio_helper.dart';

@singleton
class ProfileRepo {
  final DioHelper dioRequest;

  ProfileRepo({required this.dioRequest});

  Future<Either<FailureException, QwnerModel>> updateProfileDate({
    required QwnerModel ownerData,
    File? photo1,
  }) async {
    try {
      MultipartFile? file;
      if (photo1 != null) {
        file = await MultipartFile.fromFile(
          photo1.path,
          filename: photo1.path.split("/").last,
        );
      }

      final response = await dioRequest.post(
        endpoint: ApiUrls.updateProfileDate,
        data: {
          "BankAccount": ownerData.bankAccount,
          'OwnerID': ownerData.ownerID,
          'OwnerKey': ownerData.ownerKey,
          'OwnerPhone': ownerData.ownerPhone,
          "OwnerFName": ownerData.ownerFName,
          "OwnerLName": ownerData.ownerLName,
          "OwnerEmail": ownerData.ownerEmail,
          if (file != null) "OwnerPhoto": file,
        },
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        return Right(QwnerModel.fromJson(result["data"]));
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

  Future<Either<FailureException, TermsInfoModel>> getTerms() async {
    try {
      final response = await dioRequest.post(endpoint: ApiUrls.getTerms);
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
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again."
              .tr(),
        ),
      );
    }
  }

  Future<Either<FailureException, GetOwnerInfoModel>> getOwnerInfo() async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrls.getOwnerInfo,
        data: {
          //"OwnerID": "1"
          "OwnerID": getIt<AppPreferences>().loadUserData?.ownerID ?? "",
        },
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        GetOwnerInfoModel getOwnerInfoModel = GetOwnerInfoModel.fromJson(
          result['data'],
        );
        return Right(getOwnerInfoModel);
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

  Future<Either<FailureException, List<RefuseResonsInfoModel>>>
  getRefuseResons() async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrls.getRefuseResons,
        data: {"OwnerID": getIt<AppPreferences>().loadUserData?.ownerID ?? ""},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        RefuseResonsModel refuseResonsModel = RefuseResonsModel.fromJson(
          result,
        );
        return Right(refuseResonsModel.data ?? []);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<FailureException, String>> uploadFile({
    required UploadFileRequestModel uploadFileRequestModel,
  }) async {
    try {
      MultipartFile? file;
      if (uploadFileRequestModel.file != null) {
        file = await MultipartFile.fromFile(
          uploadFileRequestModel.file!.path,
          filename: uploadFileRequestModel.file?.path.split("/").last,
        );
      }

      final response = await dioRequest.post(
        endpoint: ApiUrls.uploadFile,
        data: {
          "ReasonsRefuseID": uploadFileRequestModel.reasonsRefuseID,
          "OwnerID": uploadFileRequestModel.reasonsRefuseID,
          "Files": file,
        },
      );
      var result = json.decode(response.data);
      print("result json.decode: $result");
      if (result['success'] == true && result['status_code'] == 200) {
        return const Right("Done");
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
