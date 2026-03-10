import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_urls.dart';
import '../../../../core/network/error_handler.dart';
import '../../../models/models_owner/owner_info.dart';
import '../../../storage/remote/dio_helper/dio_helper.dart';

@singleton
class AuthRepository {
  final DioHelper dioRequest;

  AuthRepository({required this.dioRequest});
  Future<String?> getDeviceToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token;
    if (Platform.isIOS) {
      token = await firebaseMessaging.getAPNSToken();
      print("APNS Token Ios: $token");
    } else {
      token = await firebaseMessaging.getToken();
      print("APNS Token Android: $token");
    }
    return token;
  }

  Future<Either<FailureException, int>> fetchWhatsappOTP(String phone) async {
    String? deviceToken = await getDeviceToken();
    try {
      var response =
          await dioRequest.post(endpoint: ApiUrls.whatsappOTP, data: {
        "PhoneNumber": phone,
        "FirebaseToken": deviceToken ?? "",
      });
      var result = json.decode(response.data);

      if (result['success'] == true && result['status_code'] == 200) {
        return Right(result["data"]);
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

  Future<Either<FailureException, QwnerModel>> checkOwnerExist({
    required String countryCode,
    required String phoneNumber,
  }) async {
    try {
      String? deviceToken = await getDeviceToken();
      final response = await dioRequest.post(
        endpoint: ApiUrls.checkPhone,
        data: {
          'OwnerKey': countryCode,
          'OwnerPhone': phoneNumber,
          "FirebaseToken": deviceToken ?? "",
        },
      );

      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        if (result["message"] == "NoData") return Right(QwnerModel());
        return Right(QwnerModel.fromJson(result["data"]));
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

  Future<Either<FailureException, QwnerModel>> signUpOwner(
      {required QwnerModel ownerData, File? photo1}) async {
    try {
      String? deviceToken = await getDeviceToken();
      MultipartFile? file;
      if (photo1 != null) {
        file = await MultipartFile.fromFile(photo1.path,
            filename: photo1.path.split("/").last);
      }

      final response = await dioRequest.post(
        endpoint: ApiUrls.signUpUser,
        data: {
          'OwnerKey': ownerData.ownerKey,
          'OwnerPhone': ownerData.ownerPhone,
          "OwnerFName": ownerData.ownerFName,
          "OwnerLName": ownerData.ownerLName,
          "OwnerEmail": ownerData.ownerEmail,
          'Segl':ownerData.segalDariby,
          'PHONE1':ownerData.phone1,
          'PHONE2':ownerData.phone2,
          'Type':ownerData.type,
          "FirebaseToken": deviceToken ?? "",
          if (file != null) "OwnerPhoto": file
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
      return left(ServerFailure(e.toString()));
    }
  }
}
