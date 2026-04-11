import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'error_handler.dart';
import 'network_info.dart';

@injectable
class SafeApi {
  final NetworkInfo _networkInfo;

  SafeApi(this._networkInfo);

  Future<Either<Failure, T>> call<T, M>({
    required Future<dynamic> apiCall,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call API
        final response = await apiCall;
        // if (response is! T) {
        //   throw response as Exception;
        // }
        log("Response: $response");
        log("Response: ${response.status}");
        if (response.status == true) {
          // success
          // return right
          return Right(response);
        } else {
          // failure
          // return left
          return Left(
            Failure(
              response.statusCode ?? -1,
              response.message ?? ResponseMessage.DEFAULT,
            ),
          );
        }
      } catch (error, stacktrace) {
        log("SafeApi Error: $error");
        log("$stacktrace");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return network connection error
      // return left
      log("SafeApi Error: No internet connection");
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
