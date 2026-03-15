import 'package:bloc/bloc.dart';
import '../data/models/holiday_request_model.dart';
import 'holiday_state.dart';

class HolidayCubit extends Cubit<HolidayState> {

  HolidayCubit() : super(HolidayInitial());

  final List<HolidayRequestModel> _requests = [];

  Future<void> loadRequests() async {
    emit(HolidayLoading());

    await Future.delayed(const Duration(milliseconds: 300));

    if (_requests.isEmpty) {
      emit(HolidayEmpty());
    } else {
      emit(HolidayLoaded(List.from(_requests)));
    }
  }

  Future<void> addHolidayRequest(
      DateTime startDate,
      DateTime endDate,
      String reason,
      ) async {

    final newRequest = HolidayRequestModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startDate: startDate,
      endDate: endDate,
      reason: reason,
      status: HolidayStatus.pending,
    );

    _requests.insert(0, newRequest);

    emit(HolidayLoaded(List.from(_requests)));
  }
}