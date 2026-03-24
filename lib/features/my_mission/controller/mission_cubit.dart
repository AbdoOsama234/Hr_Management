import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../data/models/mission_model.dart';
import 'mission_state.dart';

class MyMissionCubit extends Cubit<MyMissionState> {
  MyMissionCubit() : super(MyMissionInitial());

  final List<MyMissionModel> _missions = [];

  Future<void> loadMissions() async {
    emit(MyMissionLoading());

    // Simulating network delay as in holiday_cubit
    await Future.delayed(const Duration(milliseconds: 300));

    if (_missions.isEmpty) {
      _missions.addAll([
        MyMissionModel(
          id: '1',
          date: DateTime.now(),
          status: MissionStatus.pending,
          importance: MissionImportance.high,
          notes: 'mock_mission_1_notes'.tr(),
        ),
        MyMissionModel(
          id: '2',
          date: DateTime.now().add(const Duration(days: 2)),
          status: MissionStatus.approved,
          importance: MissionImportance.medium,
          notes: 'mock_mission_2_notes'.tr(),
        ),
        MyMissionModel(
          id: '3',
          date: DateTime.now().subtract(const Duration(days: 1)),
          status: MissionStatus.rejected,
          importance: MissionImportance.low,
          notes: 'mock_mission_3_notes'.tr(),
        ),
      ]);
    }

    if (_missions.isEmpty) {
      emit(MyMissionEmpty());
    } else {
      emit(MyMissionLoaded(List.from(_missions)));
    }
  }
}
