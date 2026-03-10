// import 'dart:developer' as dev;
//
// import 'package:hr_manegement/core/extensions.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:injectable/injectable.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
//
// import '../../../../core/api_urls.dart';
// import '../../../../core/di/di.dart';
// import '../../local/app_prefs.dart';
//
// @singleton
// class DioHelper {
//   late AppPreferences appPreferences;
//
//   DioHelper(this.appPreferences) {
//     _init();
//   }
//
//   late final Dio dio;
//
//   void _init() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: ApiUrls.baseUrl,
//         receiveDataWhenStatusError: true,
//         followRedirects: false,
//         validateStatus: (status) {
//           return status! < 500;
//         },
//         headers: {
//           'Accept': "application/json",
//           'Lang': appPreferences.lang,
//           'token': appPreferences.userToken
//         },
//       ),
//     );
//     if (!kReleaseMode) {
//       dio.interceptors.add(
//         PrettyDioLogger(
//           requestHeader: true,
//           requestBody: true,
//           responseBody: true,
//           responseHeader: false,
//           compact: true,
//         ),
//       );
//     }
//   }
//
//   void updateHeaderLanguage() {
//     var pref = getIt<AppPreferences>();
//     dio.options.headers.update(
//       'lang',
//       (value) => pref.lang.orEmpty() != '' ? pref.lang.orEmpty() : 'en',
//     );
//   }
//
//   Future<Response> getData({
//     required String endpoint,
//     Map<String, dynamic>? query,
//   }) async {
//     final response = await dio.get(endpoint, queryParameters: query);
//     return response;
//   }
//
//   Future<Response> post(
//       {required String endpoint,
//       Map<String, dynamic>? data,
//       Map<String, dynamic>? query,
//       bool isFormData = true}) async {
//     final response = await dio.post(
//       endpoint,
//       queryParameters: query,
//       data: data == null
//           ? null
//           : isFormData
//               ? FormData.fromMap(data)
//               : data,
//     );
//     return response;
//   }
//
//   Future<Response> postForm({
//     required String url,
//     required FormData data,
//     Map<String, dynamic>? query,
//   }) async {
//     final response = await dio.post(url, queryParameters: query, data: data);
//     dev.log((response.data['error'] != null).toString());
//
//     return response;
//   }
//
//   Future<Response> patchData({
//     required String url,
//     required dynamic data,
//     Map<String, dynamic>? query,
//   }) async {
//     final response = await dio.patch(url, queryParameters: query, data: data);
//
//     return response;
//   }
//
//   Future<Response> putData({
//     required String url,
//     required dynamic data,
//     Map<String, dynamic>? query,
//   }) async {
//     final response = await dio.put(url, queryParameters: query, data: data);
//
//     return response;
//   }
//
//   Future<Response> deleteData({
//     required String url,
//     Map<String, dynamic>? data,
//     Map<String, dynamic>? query,
//   }) async {
//     final response = await dio.delete(url, data: data, queryParameters: query);
//
//     return response;
//   }
//
//   bool isSuccessResponse({required Response<dynamic> response}) {
//     if (response.statusCode! == 200 ||
//         response.statusCode! == 201 ||
//         response.statusCode! == 204) {
//       return true;
//     }
//
//     return false;
//   }
// }
import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../local/app_prefs.dart';

/// Interceptor مسؤول عن تحديث الهيدر ديناميكياً
class AuthInterceptor extends Interceptor {
  final AppPreferences appPreferences;

  AuthInterceptor(this.appPreferences);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept'] = "application/json";
    options.headers['Lang'] = appPreferences.lang;
    options.headers['token'] = appPreferences.userToken;
    super.onRequest(options, handler);
  }
}

@singleton
class DioHelper {
  late AppPreferences appPreferences;
  late final Dio dio;

  DioHelper(this.appPreferences) {
    _init();
  }

  void _init() {
    dio = Dio(
      BaseOptions(
        //baseUrl: ApiUrlsEmployeeApp.baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    /// إضافة Interceptor للهيدر
    dio.interceptors.add(AuthInterceptor(appPreferences));

    /// إضافة Logger في حالة الـ debug
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: true,
        ),
      );
    }
  }

  Future<Response> getData({
    required String endpoint,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(endpoint, queryParameters: query);
  }

  Future<Response> post({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    bool isFormData = true,
  }) async {
    return await dio.post(
      endpoint,
      queryParameters: query,
      data: data == null
          ? null
          : isFormData
          ? FormData.fromMap(data)
          : data,
    );
  }

  Future<Response> postForm({
    required String url,
    required FormData data,
    Map<String, dynamic>? query,
  }) async {
    final response = await dio.post(url, queryParameters: query, data: data);
    dev.log((response.data['error'] != null).toString());
    return response;
  }

  Future<Response> patchData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
  }) async {
    return await dio.patch(url, queryParameters: query, data: data);
  }

  Future<Response> putData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
  }) async {
    return await dio.put(url, queryParameters: query, data: data);
  }

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    return await dio.delete(url, data: data, queryParameters: query);
  }

  bool isSuccessResponse({required Response<dynamic> response}) {
    return response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204;
  }
}
