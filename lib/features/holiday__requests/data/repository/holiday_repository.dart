import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:hr_manegement/core/extensions.dart';

import '../../../../core/api_urls.dart';
import '../../../../core/di/di.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/network/save_api.dart';
import '../../../../data/models/base_response.dart';
import '../../../../data/storage/local/app_prefs.dart';
import '../models/holiday_model.dart';
import '../models/holiday_request.dart';
import 'package:retrofit/error_logger.dart';

part 'holiday_repository.g.dart';

/// =========================
/// 🔹 API SERVICE (Retrofit)
/// =========================
@RestApi(baseUrl: ApiUrls.baseApiUrl)
abstract class HolidayServiceClient {
  factory HolidayServiceClient(Dio dio, {String baseUrl}) =
      _HolidayServiceClient;

  /// ➕ Create
  @POST(ApiUrls.holidayRequests)
  Future<BaseResponse<HolidayModel>> createHolidayRequest(
    @Body() HolidayRequest body,
  );

  /// 📥 Get all (pagination)
  @GET("${ApiUrls.holidayRequests}/{id}")
  Future<BaseResponse<AllHolidays>> getAllRequests(
      @Path('id') int id,
      @Query('page') int page,
  );

  /// update
  @POST("${ApiUrls.holidayRequests}/{id}")
  Future<BaseResponse<int>> updateHoliday(
    @Path("id") int id,
    @Body() HolidayRequest body,
  );

  @DELETE("${ApiUrls.holidayRequests}/{id}")
  Future<BaseResponse<dynamic>> deleteHoliday(@Path("id") int id);
}

/// =========================
/// 🔹 REPOSITORY
/// =========================
@injectable
class HolidayRepository {
  final HolidayServiceClient _service;
  final SafeApi _safeApi;

  HolidayRepository(this._service, this._safeApi);

  /// 📥 Get all
  Future<Either<Failure, BaseResponse<AllHolidays>>> getAllRequests(
      int page,
      ) async {
    return await _safeApi.call(apiCall: _service.getAllRequests(
        (
            getIt<AppPreferences>().loadUserData?.id).orZero(),

        page));
  }

  /// ➕ Create
  Future<Either<Failure, BaseResponse<HolidayModel>>> createHolidayRequest(
    HolidayRequest body,
  ) async {
    return await _safeApi.call(apiCall: _service.createHolidayRequest(body));
  }

  ///Update
  Future<Either<Failure, BaseResponse<int>>> updateHoliday(
    int id,
    HolidayRequest body,
  ) async {
    return await _safeApi.call(apiCall: _service.updateHoliday(id, body));
  }

  ///Delete
  Future<Either<Failure, BaseResponse<dynamic>>> deleteHoliday(int id) async {
    return await _safeApi.call(apiCall: _service.deleteHoliday(id));
  }
}
