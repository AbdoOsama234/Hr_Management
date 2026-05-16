// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      log('erorr handeler file');
      log(error.response.toString());
      log((error.response?.statusMessage).toString());
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        String message = tryToGetMessageFromResponse(
          error.response!,
          error.response!.statusMessage!,
        );
        log('message');
        log(message);
        if (error.response?.statusCode == ResponseCode.UNAUTORISED) {
          log("object");
          log((error.response?.statusCode.orZero()).toString());
          //TODO: logOut if user is UNAUTORISED
          //logOut(navigatorKey.currentState!.context);
          //end for background tracking
          //await BackgroundTrackingManager.stop();
        }

        return Failure(error.response?.statusCode ?? 0, message);
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.unknown:
    case DioExceptionType.badCertificate:
    case DioExceptionType.connectionError:
      return DataSource.DEFAULT.getFailure();
  }
}

String tryToGetMessageFromResponse(Response response, String defaultMessage) {
  try {
    return response.data['title'];
  } catch (error) {
    return defaultMessage;
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS.tr());
      case DataSource.NO_CONTENT:
        return Failure(
          ResponseCode.NO_CONTENT,
          ResponseMessage.NO_CONTENT.tr(),
        );
      case DataSource.BAD_REQUEST:
        return Failure(
          ResponseCode.BAD_REQUEST,
          ResponseMessage.BAD_REQUEST.tr(),
        );
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN.tr());
      case DataSource.UNAUTORISED:
        return Failure(
          ResponseCode.UNAUTORISED,
          ResponseMessage.UNAUTORISED.tr(),
        );
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND.tr());
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
          ResponseCode.INTERNAL_SERVER_ERROR,
          ResponseMessage.INTERNAL_SERVER_ERROR.tr(),
        );
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
          ResponseCode.CONNECT_TIMEOUT,
          ResponseMessage.CONNECT_TIMEOUT.tr(),
        );
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL.tr());
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
          ResponseCode.RECIEVE_TIMEOUT,
          ResponseMessage.RECIEVE_TIMEOUT.tr(),
        );
      case DataSource.SEND_TIMEOUT:
        return Failure(
          ResponseCode.SEND_TIMEOUT,
          ResponseMessage.SEND_TIMEOUT.tr(),
        );
      case DataSource.CACHE_ERROR:
        return Failure(
          ResponseCode.CACHE_ERROR,
          ResponseMessage.CACHE_ERROR.tr(),
        );
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(
          ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION.tr(),
        );
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT.tr());
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = AppErrorMessages.success; // success with data
  static const String NO_CONTENT =
      AppErrorMessages.success; // success with no data (no content)
  static const String BAD_REQUEST =
      AppErrorMessages.badRequestError; // failure, API rejected request
  static const String UNAUTORISED =
      AppErrorMessages.unauthorizedError; // failure, user is not authorised
  static const String FORBIDDEN =
      AppErrorMessages.forbiddenError; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      AppErrorMessages.internalServerError; // failure, crash in server side
  static const String NOT_FOUND =
      AppErrorMessages.notFoundError; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = AppErrorMessages.timeoutError;
  static const String CANCEL = AppErrorMessages.defaultError;
  static const String RECIEVE_TIMEOUT = AppErrorMessages.timeoutError;
  static const String SEND_TIMEOUT = AppErrorMessages.timeoutError;
  static const String CACHE_ERROR = AppErrorMessages.cacheError;
  static const String NO_INTERNET_CONNECTION = AppErrorMessages.noInternetError;
  static const String DEFAULT = AppErrorMessages.defaultError;
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}

class AppErrorMessages {
  static const String success = 'success';
  // error handler
  static const String badRequestError = 'bad_request_error';
  static const String noContent = 'no_content';
  static const String forbiddenError = 'forbidden_error';
  static const String unauthorizedError = 'unauthorized_error';
  static const String notFoundError = 'not_found_error';
  static const String conflictError = 'conflict_error';
  static const String internalServerError = 'internal_server_error';
  static const String unknownError = 'unknown_error';
  static const String timeoutError = 'timeout_error';
  static const String defaultError = 'default_error';
  static const String cacheError = 'cache_error';
  static const String noInternetError = 'no_internet_error';
}

class Failure {
  int code; // 200, 201, 400, 303..500 and so on
  String message; // error , success

  Failure(this.code, this.message);
}

abstract class FailureException {
  final String message;

  FailureException(this.message);
}

class ServerFailure extends FailureException {
  ServerFailure(super.message);

  factory ServerFailure.fromDiorError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with api server');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('badCertificate with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode!,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure('Your request was not found, please try later');
    } else if (statusCode == 500) {
      return ServerFailure('There is a problem with server, please try later');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else {
      return ServerFailure('There was an error , please try again');
    }
  }
}
