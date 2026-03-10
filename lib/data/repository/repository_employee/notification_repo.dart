import 'dart:convert';

import 'package:hr_manegement/core/api_urls.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../core/network/error_handler.dart';
import '../../models/models_employee/EmployeeNotificationModel.dart';
import '../../models/models_employee/NotificationNotSeenCountModel.dart';
import '../../storage/remote/dio_helper/dio_helper.dart';

@injectable
class NotificationRepo {
  final DioHelper dioRequest;

  NotificationRepo({required this.dioRequest});
  Future<Either<FailureException, List<EmployeeNotificationInfoModel>>>
  getEmployeeNotification({required String employeeID}) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.getEmployeeNotification,
        data: {"EmployeeID": employeeID},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        EmployeeNotificationModel employeeNotificationModel =
            EmployeeNotificationModel.fromJson(result);
        return Right(employeeNotificationModel.data!);
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

  Future<Either<FailureException, List<NotificationNotSeenCountInfoModel>>>
  getNotificationNotSeenCount({required String employeeID}) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrlsEmployeeApp.getNotificationNotSeenCount,
        data: {"EmployeeID": employeeID},
      );
      var result = json.decode(response.data);
      if (result['success'] == true && result['status_code'] == 200) {
        NotificationNotSeenCountModel notificationNotSeenCountModel =
            NotificationNotSeenCountModel.fromJson(result);
        return Right(notificationNotSeenCountModel.data!);
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
