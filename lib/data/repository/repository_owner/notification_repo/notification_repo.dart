import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api_urls.dart';
import '../../../../core/network/error_handler.dart';
import '../../../models/models_owner/GetOwnerNotificationRequestModel.dart';
import '../../../models/models_owner/NotificationNotSeenCountModel.dart';
import '../../../models/models_owner/OwnerNotificationModel.dart';
import '../../../storage/remote/dio_helper/dio_helper.dart';
@injectable
class NotificationRepo{
  final DioHelper dioRequest;

  NotificationRepo({required this.dioRequest});
  Future<Either<FailureException, List<OwnerNotificationInfoModel>>> getOwnerNotification(
      {required GetOwnerNotificationRequestModel getOwnerNotificationRequestModel}) async {
    try{
      final response = await dioRequest.post(
        endpoint: ApiUrls.getOwnerNotification,
        data: getOwnerNotificationRequestModel.toJson()
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        OwnerNotificationModel  ownerNotificationModel = OwnerNotificationModel.fromJson(result);
        return Right(ownerNotificationModel.data!);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure("Something went wrong. Please check your internet connection and try again.".tr()));
    }
  }
  Future<Either<FailureException, List<NotificationNotSeenCountInfoModel>>> getNotificationNotSeenCount({required String ownerID}) async {
    try{
      final response = await dioRequest.post(
        endpoint: ApiUrls.getNotificationNotSeenCount,
        data: {
          "OwnerID":ownerID
        }
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        NotificationNotSeenCountModel  notificationNotSeenCountModel = NotificationNotSeenCountModel.fromJson(result);
        return Right(notificationNotSeenCountModel.data!);
      } else {
        return Left(ServerFailure(result['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure("Something went wrong. Please check your internet connection and try again.".tr()));
    }
  }
}