import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../data/models/my_mission_model.dart';
import '../data/models/my_mission_details_model.dart';
import '../data/models/my_mission_request.dart';
import '../data/repository/my_mission_repository.dart';
import 'my_mission_state.dart';

@injectable
class MyMissionCubit extends Cubit<MyMissionState> {
  final MyMissionRepository _repository;

  static MyMissionCubit get(BuildContext context) =>
      context.read<MyMissionCubit>();

  MyMissionCubit(this._repository) : super(MyMissionInitial());

  /// 📥 DATA
  List<MyMissionModel> missions = [];
  MyMissionDetailsModel? missionDetails;
  int _currentPage = 1;
  bool _hasNext = true;

  Future<void> getAllMissions({bool loadMore = false}) async {
    if (state is GetAllMissionsLoading ||
        state is PaginationLoading ||
        (loadMore && !_hasNext)) {
      return;
    }

    if (loadMore) {
      emit(PaginationLoading());
    } else {
      missions.clear();
      _currentPage = 1;
      _hasNext = true;
      emit(GetAllMissionsLoading());
    }

    final result = await _repository.getAllTasks(_currentPage);
    result.fold(
      (l) {
        emit(GetAllMissionsError(error: l.message));
      },
      (r) {
        missions.addAll(r.result?.tasks ?? []);
        _hasNext = r.result?.pagination?.hasNext ?? false;
        if (_hasNext) {
          _currentPage++;
        }
        emit(GetAllMissionsLoaded());
      },
    );
  }

  /// 📥 GET DETAILS
  Future<void> getMissionDetails(int id) async {
    emit(GetMissionDetailsLoading());

    final result = await _repository.getTaskDetails(id);

    result.fold(
      (failure) {
        emit(GetMissionDetailsError(error: failure.message));
      },
      (response) {
        missionDetails = response.result;
        emit(GetMissionDetailsLoaded());
      },
    );
  }

  /// 🔄 UPDATE
  Future<void> updateMission({
    required int id,
    required MyMissionRequest model,
  }) async {
    emit(UpdateMissionLoading(id: id));

    final result = await _repository.updateTask(id, model);

    result.fold(
      (failure) {
        emit(UpdateMissionError(error: failure.message));
      },
      (response) async {
        missionDetails = response.result;
        emit(UpdateMissionSuccess());
        await getAllMissions(); // Refresh list
      },
    );
  }
}
