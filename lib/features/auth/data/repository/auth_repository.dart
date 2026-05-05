import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:hr_manegement/core/network/error_handler.dart';
import 'package:retrofit/http.dart';
import '../../../../core/api_urls.dart';
import '../../../../core/network/save_api.dart';
import '../../../../data/models/base_response.dart';

import 'package:retrofit/error_logger.dart';

import '../model/user_model.dart';

part 'auth_repository.g.dart';

@RestApi(baseUrl: ApiUrls.baseApiUrl)
abstract class AuthServiceClient {
  factory AuthServiceClient(Dio dio, {String baseUrl}) = _AuthServiceClient;

  @POST(ApiUrls.login)
  Future<BaseResponse<LoginModel>> login(@Body() Map<String, dynamic> body);
}

@injectable
class AuthRepository {
  final AuthServiceClient _authServiceClient;
  final SafeApi _safeApi;

  AuthRepository(this._authServiceClient, this._safeApi);

  Future<Either<Failure, BaseResponse<LoginModel>>> login(
    String email,
    String password,
  ) async {
    return await _safeApi.call(
      apiCall: _authServiceClient.login({"email": email, "password": password}),
    );
  }
}
