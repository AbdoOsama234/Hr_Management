import 'dart:developer';
import 'dart:io';

import 'package:hr_manegement/core/di/di.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../data/storage/local/app_prefs.dart';
import '../../api_urls.dart';
import '../../constants.dart';

const String applicationJson = "application/json";
const String contentType = 'content-type';
const String accept = 'accept';
const String acceptLanguage = 'accept-language';
const String authorization = 'authorization';

@module
abstract class DioModule {
  @preResolve
  @factoryMethod
  Future<Dio> getDio(AppPreferences preferences) async {
    Dio dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.updateHeader(preferences);
    if (kDebugMode) {
      dio.interceptors.addAll([
        PrettyDioLogger(
          requestBody: true,
          responseBody: true,
          request: true,
          requestHeader: true,
          responseHeader: true,
          logPrint: (object) {
            log(object.toString());
          },
        ),
      ]);
    }

    return dio;
  }
}

extension DioHeader on Dio {
  void updateHeader(AppPreferences preferences) {
    String token = preferences.userToken;
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      if (getIt<AppPreferences>().userToken.isNotEmpty)
        authorization: 'Bearer $token',
      acceptLanguage: preferences.lang,
    };
    options = BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      headers: headers,
      receiveTimeout: const Duration(milliseconds: Constants.apiTimeOut),
      sendTimeout: const Duration(milliseconds: Constants.apiTimeOut),

      //TODO: change this
      // validateStatus: (status) {
      //   return status! < 500; // Allow status codes <500 (400 won't throw)
      // },
    );
  }
}
