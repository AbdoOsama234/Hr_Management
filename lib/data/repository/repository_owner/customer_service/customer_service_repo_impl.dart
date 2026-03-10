import 'dart:convert';
import 'package:hr_manegement/core/api_urls.dart';
import 'package:hr_manegement/core/network/error_handler.dart';
import 'package:hr_manegement/data/models/models_owner/customer_service_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../models/models_owner/ContactUsRequestModel.dart';
import '../../../storage/remote/dio_helper/dio_helper.dart';

@singleton
class CustomServiceRepo {
  final DioHelper dioRequest;

  CustomServiceRepo({required this.dioRequest});

  Future<Either<FailureException, CustomerServiceInfo>>
  fetchCustomerService() async {
    try {
      var response = await dioRequest.post(
        endpoint: ApiUrls.getCustomerService,
      );
      var result;
      print("response.data : ${response.data}");
      if (response.data is String) {
        result = json.decode(response.data);
      } else {
        result = response.data;
      }
      CustomerServiceModel customerServiceModel = CustomerServiceModel.fromJson(
        result,
      );
      print("result = : $result");
      print("onBoardingModel ${customerServiceModel.data?.length}");
      return right(customerServiceModel.data![0]);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(
        ServerFailure(
          "Something went wrong. Please check your internet connection and try again.",
        ),
      );
    }
  }

  Future<Either<FailureException, bool>> contactUs({
    required ContactUsRequestModel contactUsRequestModel,
  }) async {
    try {
      final response = await dioRequest.post(
        endpoint: ApiUrls.contactUs,
        data: contactUsRequestModel.toJson(),
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
          "Something went wrong. Please check your internet connection and try again.",
        ),
      );
    }
  }
}
