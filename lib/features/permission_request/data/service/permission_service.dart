import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../core/api_urls.dart';
import '../../../../data/models/base_response.dart';
import '../models/all_permissions.dart';
import '../models/permission_model.dart';
import '../models/permission_request.dart';
import 'package:retrofit/error_logger.dart';

part 'permission_service.g.dart';

@RestApi(baseUrl: ApiUrls.baseApiUrl)
abstract class PermissionServiceClient {
  factory PermissionServiceClient(Dio dio, {String baseUrl}) =
      _PermissionServiceClient;

  @POST(ApiUrls.permissionRequest)
  Future<BaseResponse<PermissionModel>> createPermission(
    @Body() PermissionRequest body,
  );

  @GET(ApiUrls.permissionRequest)
  Future<BaseResponse<AllPermissions>> getAllPermissions(
    @Query('page') int page,
  );

  @POST("${ApiUrls.permissionRequest}/{id}")
  Future<BaseResponse<int>> updatePermission(
    @Path("id") int id,
    @Body() PermissionRequest body,
  );

  @DELETE("${ApiUrls.permissionRequest}/{id}")
  Future<BaseResponse<dynamic>> deletePermission(@Path("id") int id);
}
