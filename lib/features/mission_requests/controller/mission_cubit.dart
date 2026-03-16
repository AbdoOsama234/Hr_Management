import 'package:bloc/bloc.dart';
import '../data/models/mission_request_model.dart';
import 'mission_state.dart';

class MissionCubit extends Cubit<MissionState> {
  MissionCubit() : super(MissionInitial());

  final List<MissionRequestModel> _requests = [];

  Future<void> loadRequests() async {
    emit(MissionLoading());

    await Future.delayed(const Duration(milliseconds: 300));

    if (_requests.isEmpty) {
      emit(MissionEmpty());
    } else {
      emit(MissionLoaded(List.from(_requests)));
    }
  }

  Future<void> addMissionRequest(
    DateTime startDate,
    DateTime endDate,
    int days,
    String reason,
  ) async {
    final newRequest = MissionRequestModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startDate: startDate,
      endDate: endDate,
      days: days,
      reason: reason,
      status: MissionStatus.pending,
    );

    _requests.insert(0, newRequest);

    emit(MissionLoaded(List.from(_requests)));
  }

  Future<void> deleteRequest(String id) async {
    _requests.removeWhere((request) => request.id == id);
    if (_requests.isEmpty) {
      emit(MissionEmpty());
    } else {
      emit(MissionLoaded(List.from(_requests)));
    }
  }

  Future<void> editRequest(
    String id,
    DateTime startDate,
    DateTime endDate,
    int days,
    String reason,
  ) async {
    final request = _requests.firstWhere((request) => request.id == id);
    request.startDate = startDate;
    request.endDate = endDate;
    request.days = days;
    request.reason = reason;
    emit(MissionLoaded(List.from(_requests)));
  }
}
