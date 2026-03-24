import '../data/models/mission_model.dart';

abstract class MyMissionState {}

class MyMissionInitial extends MyMissionState {}

class MyMissionLoading extends MyMissionState {}

class MyMissionEmpty extends MyMissionState {}

class MyMissionLoaded extends MyMissionState {
  final List<MyMissionModel> missions;

  MyMissionLoaded(this.missions);
}
