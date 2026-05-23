import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hr_manegement/core/extensions.dart';

import '../../../../core/di/di.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/network/save_api.dart';
import '../../../../data/models/base_response.dart';
import '../../../../data/storage/local/app_prefs.dart';
import '../models/my_mission_model.dart';
import '../models/my_mission_details_model.dart';
import '../models/my_mission_request.dart';
import '../service/my_mission_service.dart';

/// =========================
/// 🔹 REPOSITORY
/// =========================
@injectable
class MyMissionRepository {
  final MyMissionServiceClient _service;
  final SafeApi _safeApi;

  MyMissionRepository(this._service, this._safeApi);

  /// 📥 Get all tasks
  Future<Either<Failure, BaseResponse<AllMyMissions>>> getAllTasks(
    int page,
  ) async {
    return await _safeApi.call(apiCall: _service.getAllTasks(
        (getIt<AppPreferences>().loadUserData?.id).orZero(),

        page));
  }

  /// 📥 Get task details
  Future<Either<Failure, BaseResponse<MyMissionDetailsModel>>> getTaskDetails(
    int id,
  ) async {
    return await _safeApi.call(apiCall: _service.getTaskDetails(id));
  }

  /// 🔄 Update task
  Future<Either<Failure, BaseResponse<MyMissionDetailsModel>>> updateTask(
    int id,
    MyMissionRequest body,
  ) async {
    return await _safeApi.call(apiCall: _service.updateTask(id, body));
  }
}
