import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../core/api_urls.dart';
import '../../../../data/models/base_response.dart';
import '../models/my_mission_model.dart';
import '../models/my_mission_details_model.dart';
import '../models/my_mission_request.dart';
import 'package:retrofit/error_logger.dart';

part 'my_mission_service.g.dart';

/// =========================
/// 🔹 API SERVICE (Retrofit)
/// =========================
@RestApi(baseUrl: ApiUrls.baseApiUrl)
abstract class MyMissionServiceClient {
  factory MyMissionServiceClient(Dio dio, {String baseUrl}) =
      _MyMissionServiceClient;

  /// 📥 Get all tasks (pagination)
  @GET("${ApiUrls.tasks}/{id}")
  Future<BaseResponse<AllMyMissions>> getAllTasks(
      @Path('id') int id,
      @Query('page') int page);

  /// 📥 Get task details by id
  @GET("${ApiUrls.tasks}/show/{id}")
  Future<BaseResponse<MyMissionDetailsModel>> getTaskDetails(
    @Path("id") int id,
  );

  /// 🔄 Update task
  @POST("${ApiUrls.tasks}/update/{id}")
  Future<BaseResponse<MyMissionDetailsModel>> updateTask(
    @Path("id") int id,
    @Body() MyMissionRequest body,
  );
}
