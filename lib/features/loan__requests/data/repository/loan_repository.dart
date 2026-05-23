import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/features/loan__requests/data/models/loan_model.dart';
import 'package:hr_manegement/features/loan__requests/data/models/loan_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/api_urls.dart';

import '../../../../core/di/di.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/network/save_api.dart';
import '../../../../data/models/base_response.dart';
import '../../../../data/storage/local/app_prefs.dart';

part 'loan_repository.g.dart';


@RestApi(baseUrl: ApiUrls.baseApiUrl,)

abstract class LoanServiceClient {
  factory LoanServiceClient(Dio dio,{String baseUrl,})=
  _LoanServiceClient;


/// 📥 GET ALL
@GET("${ApiUrls.loanRequests}/{id}")
Future<BaseResponse<AllLoans>> getAllLoans(
    @Path('id') int id,
    @Query('page') int page,);





/// ➕ CREATE
@POST(ApiUrls.loanRequests)
Future<BaseResponse<LoanModel>> createLoans(@Body() LoanRequest body,);
/// ✏ UPDATE
@POST("${ApiUrls.loanRequests}/{id}",)
Future<BaseResponse<int>> updateLoans(@Path("id") int id, @Body() LoanRequest body,);

/// 🗑 DELETE

@DELETE("${ApiUrls.loanRequests}/{id}",)
Future<BaseResponse<dynamic>> deleteLoans(@Path("id") int id,);
}




@injectable
class LoanRepository {

final LoanServiceClient _service;

final SafeApi _safeApi;

LoanRepository(
this._service,
this._safeApi,
);

/// =========================
/// 📥 GET ALL
/// =========================
Future<Either<Failure,BaseResponse<AllLoans>>>getAllLoans(int page,) async {
return await _safeApi.call(apiCall: _service.getAllLoans(
  (getIt<AppPreferences>().loadUserData?.id).orZero(),
    page,

),);
}

/// =========================
/// ➕ CREATE
/// =========================
Future<Either<Failure,BaseResponse<LoanModel>>>createLoans(LoanRequest body,) async {
return await _safeApi.call(apiCall: _service.createLoans(body),);
}

/// =========================
/// ✏ UPDATE
/// =========================
Future<Either<Failure,BaseResponse<int>>>updateLoans(int id,LoanRequest body,)async {
return await _safeApi.call(apiCall: _service.updateLoans(id,body,),
);
}

/// =========================
/// 🗑 DELETE
/// =========================
Future<Either<Failure,BaseResponse<dynamic>>>deleteLoans(int id,) async {
return await _safeApi.call(apiCall: _service.deleteLoans(id),
);
}















}
