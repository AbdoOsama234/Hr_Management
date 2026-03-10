import 'dart:convert';

import 'package:hr_manegement/core/network/error_handler.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_urls.dart';
import '../../../models/models_owner/on_boarding_model.dart';
import '../../../storage/remote/dio_helper/dio_helper.dart';

@singleton
class OnBoardingRepo {
  final DioHelper dioRequest;

  OnBoardingRepo({required this.dioRequest});

  Future<Either<FailureException, List<OnBoardingInfo>>>
  getOnBoardingData() async {
    try {
      var response = await dioRequest.getData(
        endpoint: ApiUrls.onBoardingIntro,
      );
      var result;
      print("response.data : ${response.data}");
      if (response.data is String) {
        result = json.decode(response.data);
      } else {
        result = response.data;
      }
      OnBoardingModel onBoardingModel = OnBoardingModel.fromJson(result);
      print("result = : $result");
      print("onBoardingModel ${onBoardingModel.data?.length}");
      return right(onBoardingModel.data!);
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
