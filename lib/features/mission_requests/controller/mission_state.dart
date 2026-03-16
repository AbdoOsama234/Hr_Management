import '../data/models/mission_request_model.dart';

abstract class MissionState {}

class MissionInitial extends MissionState {}

class MissionLoading extends MissionState {}

class MissionEmpty extends MissionState {}

class MissionLoaded extends MissionState {
  final List<MissionRequestModel> requests;

  MissionLoaded(this.requests);
}
