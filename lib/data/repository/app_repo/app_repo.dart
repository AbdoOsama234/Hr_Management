import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api_urls.dart';
import '../../../core/network/error_handler.dart';
import '../../models/models_owner/NeedUpdateModel.dart';
import '../../storage/remote/dio_helper/dio_helper.dart';

@singleton
class AppRepo {
  final DioHelper dioRequest;

  AppRepo({required this.dioRequest});

  Future<Either<FailureException, String?>> checkForUpdate() async {
    try {
      // Get current app version
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // String version = packageInfo.version;
      // NOTE THIS IS A TEMPORARY SOLUTION TO BYPASS THE VERSION CHECKING
      String version ='1' ;
      var response = await dioRequest.post(
        endpoint: ApiUrls.needUpdate,
        data: {
          "Vers": version,
        },
      );
      
      var result = json.decode(response.data);
      
      if (result['success'] == true && result['status_code'] == 200) {
        NeedUpdateModel needUpdateModel = NeedUpdateModel.fromJson(result);
        return Right(needUpdateModel.data);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(
          "Something went wrong. Please check your internet connection and try again."));
    }
  }
}
