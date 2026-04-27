import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../core/api_urls.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/network/save_api.dart';
import '../../../../data/models/base_response.dart';
import '../models/business_trip_model.dart';
import '../models/business_trip_request.dart';
import 'package:retrofit/error_logger.dart';

part 'business_trip_repository.g.dart';

/// =========================
/// 🔹 API SERVICE (Retrofit)
/// =========================
@RestApi(baseUrl: ApiUrls.baseApiUrl)
abstract class BusinessTripServiceClient {
  factory BusinessTripServiceClient(Dio dio, {String baseUrl}) =
  _BusinessTripServiceClient;

  /// ➕ Create
  @POST(ApiUrls.businessTripRequest)
  Future<BaseResponse<BusinessTripModel>> createTripRequest(
      @Body() BusinessTripRequest body,
      );

  /// 📥 Get all (pagination)
  @GET(ApiUrls.businessTripRequest)
  Future<BaseResponse<AllBusinessTrips>> getAllRequests(
      @Query('page') int page,
      );

  @DELETE("${ApiUrls.businessTripRequest}/{id}")
  Future<BaseResponse<dynamic>> deleteTrip(
      @Path("id") int id,
      );
}

/// =========================
/// 🔹 REPOSITORY
/// =========================
@injectable
class BusinessTripRepository {
  final BusinessTripServiceClient _service;
  final SafeApi _safeApi;

  BusinessTripRepository(this._service, this._safeApi);

  /// ➕ Create
  Future<Either<Failure, BaseResponse<BusinessTripModel>>> createTripRequest(
      BusinessTripRequest body) async {
    return await _safeApi.call(
      apiCall: _service.createTripRequest(body),
    );
  }

  /// 📥 Get all
  Future<Either<Failure, BaseResponse<AllBusinessTrips>>> getAllRequests(
      int page) async {
    return await _safeApi.call(
      apiCall: _service.getAllRequests(page),
    );

  }
  Future<Either<Failure, BaseResponse<dynamic>>> deleteTrip(int id) async {
    return await _safeApi.call(
      apiCall: _service.deleteTrip(id),
    );
  }
}