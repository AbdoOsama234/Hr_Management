import 'package:bloc/bloc.dart';
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
      emit(MyMissionEmpty());
    } else {
      emit(MyMissionLoaded(List.from(_missions)));
    }
  }
}
