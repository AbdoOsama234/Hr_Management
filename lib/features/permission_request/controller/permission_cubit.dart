import 'package:bloc/bloc.dart';
import '../data/models/permission_request_model.dart';
import 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(PermissionInitial());

  final List<PermissionRequestModel> _requests = [];

  Future<void> loadRequests() async {
    emit(PermissionLoading());

    await Future.delayed(const Duration(milliseconds: 300));

    if (_requests.isEmpty) {
      emit(PermissionEmpty());
    } else {
      emit(PermissionLoaded(List.from(_requests)));
    }
  }

  Future<void> addPermissionRequest(
    DateTime startDate,
    DateTime endDate,
    double hours,
    String reason,
  ) async {
    final newRequest = PermissionRequestModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startDate: startDate,
      endDate: endDate,
      hours: hours,
      reason: reason,
      status: PermissionStatus.pending,
    );

    _requests.insert(0, newRequest);

    emit(PermissionLoaded(List.from(_requests)));
  }

  Future<void> deleteRequest(String id) async {
    _requests.removeWhere((request) => request.id == id);
    if (_requests.isEmpty) {
      emit(PermissionEmpty());
    } else {
      emit(PermissionLoaded(List.from(_requests)));
    }
  }

  Future<void> editRequest(
    String id,
    DateTime startDate,
    DateTime endDate,
    double hours,
    String reason,
  ) async {
    final request = _requests.firstWhere((request) => request.id == id);
    request.startDate = startDate;
    request.endDate = endDate;
    request.hours = hours;
    request.reason = reason;
    emit(PermissionLoaded(List.from(_requests)));
  }
}
