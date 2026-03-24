import 'package:bloc/bloc.dart';
import '../data/models/errand_request_model.dart';
import 'errand_state.dart';

class ErrandCubit extends Cubit<ErrandState> {
  ErrandCubit() : super(ErrandInitial());

  final List<ErrandRequestModel> _requests = [];

  Future<void> loadRequests() async {
    emit(ErrandLoading());

    await Future.delayed(const Duration(milliseconds: 300));

    if (_requests.isEmpty) {
      emit(ErrandEmpty());
    } else {
      emit(ErrandLoaded(List.from(_requests)));
    }
  }

  Future<void> addErrandRequest(
    DateTime startDate,
    DateTime endDate,
    int days,
    String reason,
  ) async {
    final newRequest = ErrandRequestModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startDate: startDate,
      endDate: endDate,
      days: days,
      reason: reason,
      status: ErrandStatus.pending,
    );

    _requests.insert(0, newRequest);

    emit(ErrandLoaded(List.from(_requests)));
  }

  Future<void> deleteRequest(String id) async {
    _requests.removeWhere((request) => request.id == id);
    if (_requests.isEmpty) {
      emit(ErrandEmpty());
    } else {
      emit(ErrandLoaded(List.from(_requests)));
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
    emit(ErrandLoaded(List.from(_requests)));
  }
}

