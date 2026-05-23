import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:hr_manegement/core/extensions.dart';

import '../../../../core/api_urls.dart';
import '../../../../core/di/di.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/network/save_api.dart';

import '../../../../data/models/base_response.dart';

import '../../../../data/storage/local/app_prefs.dart';
import '../models/errand_model.dart';
import '../models/errand_request.dart';

part 'errand_repository.g.dart';

/// =========================
/// 🔹 API SERVICE
/// =========================
@RestApi(baseUrl: ApiUrls.baseApiUrl,)

abstract class ErrandServiceClient {
  factory ErrandServiceClient(Dio dio, {String baseUrl,}) =
  _ErrandServiceClient;

  /// 📥 GET ALL
  @GET("${ApiUrls.errandRequests}/{id}")
  Future<BaseResponse<AllErrand>> getAll(
      @Path('id') int id,
      @Query('page') int page,);


  /// ➕ CREATE
  @POST(ApiUrls.errandRequests)
  Future<BaseResponse<ErrandModel>> createErrands(@Body() ErrandRequest body,);
  /// ✏ UPDATE
  @POST("${ApiUrls.errandRequests}/{id}",)
  Future<BaseResponse<int>> updateErrands(@Path("id") int id, @Body() ErrandRequest body,);

  /// 🗑 DELETE

  @DELETE("${ApiUrls.errandRequests}/{id}",)
  Future<BaseResponse<dynamic>> deleteErrands(@Path("id") int id,);
}

/// =========================
/// 🔹 REPOSITORY
/// =========================
@injectable
class ErrandRepository {

  final ErrandServiceClient _service;

  final SafeApi _safeApi;

  ErrandRepository(
      this._service,
      this._safeApi,
      );

  /// =========================
  /// 📥 GET ALL
  /// =========================
  Future<Either<Failure,BaseResponse<AllErrand>>>getAllErrands(int page,) async {
    return await _safeApi.call(apiCall: _service.getAll(
        (getIt<AppPreferences>().loadUserData?.id).orZero(),
        page
    ),);
  }

  /// =========================
  /// ➕ CREATE
  /// =========================
  Future<Either<Failure,BaseResponse<ErrandModel>>>createErrands(ErrandRequest body,) async {
    return await _safeApi.call(apiCall: _service.createErrands(body),);
  }

  /// =========================
  /// ✏ UPDATE
  /// =========================
  Future<Either<Failure,BaseResponse<int>>>updateErrands(int id,ErrandRequest body,)async {
    return await _safeApi.call(apiCall: _service.updateErrands(id,body,),
    );
  }

  /// =========================
  /// 🗑 DELETE
  /// =========================
  Future<Either<Failure,BaseResponse<dynamic>>>deleteErrands(int id,) async {
    return await _safeApi.call(apiCall: _service.deleteErrands(id),
    );
  }
}