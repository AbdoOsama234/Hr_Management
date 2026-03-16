import 'package:bloc/bloc.dart';
import '../data/models/business_trip_request_model.dart';
import 'business_trip_state.dart';

class BusinessTripCubit extends Cubit<BusinessTripState> {
  BusinessTripCubit() : super(BusinessTripInitial());

  final List<BusinessTripRequestModel> _requests = [];

  Future<void> loadRequests() async {
    emit(BusinessTripLoading());

    await Future.delayed(const Duration(milliseconds: 300));

    if (_requests.isEmpty) {
      emit(BusinessTripEmpty());
    } else {
      emit(BusinessTripLoaded(List.from(_requests)));
    }
  }

  Future<void> addBusinessTripRequest(
    DateTime startDate,
    DateTime endDate,
    int days,
    String reason,
  ) async {
    final newRequest = BusinessTripRequestModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startDate: startDate,
      endDate: endDate,
      days: days,
      reason: reason,
      status: BusinessTripStatus.pending,
    );

    _requests.insert(0, newRequest);

    emit(BusinessTripLoaded(List.from(_requests)));
  }

  Future<void> deleteRequest(String id) async {
    _requests.removeWhere((request) => request.id == id);
    if (_requests.isEmpty) {
      emit(BusinessTripEmpty());
    } else {
      emit(BusinessTripLoaded(List.from(_requests)));
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
    emit(BusinessTripLoaded(List.from(_requests)));
  }
}
