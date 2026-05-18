import 'package:dartz/dartz.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/data/storage/local/app_prefs.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/error_handler.dart';
import '../../../../core/network/save_api.dart';
import '../../../../data/models/base_response.dart';
import '../models/all_permissions.dart';
import '../models/permission_model.dart';
import '../models/permission_request.dart';
import '../service/permission_service.dart';

@injectable
class PermissionRepository {
  final PermissionServiceClient _service;
  final SafeApi _safeApi;

  PermissionRepository(this._service, this._safeApi);

  Future<Either<Failure, BaseResponse<AllPermissions>>> getAllPermissions(
    int page,
  ) async {
    return await _safeApi.call(
      apiCall: _service.getAllPermissions(
        (getIt<AppPreferences>().loadUserData?.id).orZero(),
        page,
      ),
    );
  }

  Future<Either<Failure, BaseResponse<PermissionModel>>> createPermission(
    PermissionRequest body,
  ) async {
    return await _safeApi.call(apiCall: _service.createPermission(body));
  }

  Future<Either<Failure, BaseResponse<int>>> updatePermission(
    int id,
    PermissionRequest body,
  ) async {
    return await _safeApi.call(apiCall: _service.updatePermission(id, body));
  }

  Future<Either<Failure, BaseResponse<dynamic>>> deletePermission(
    int id,
  ) async {
    return await _safeApi.call(apiCall: _service.deletePermission(id));
  }
}
