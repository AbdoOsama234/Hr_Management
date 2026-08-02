import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../data/models/holiday_model.dart';
import '../data/models/holiday_request.dart';
import '../data/repository/holiday_repository.dart';
import 'holiday_state.dart';

@injectable
class HolidayCubit extends Cubit<HolidayState> {
  final HolidayRepository _repository;

  static HolidayCubit get(BuildContext context) => context.read<HolidayCubit>();

  HolidayCubit(this._repository) : super(HolidayInitial());

  /// 📥 DATA
  List<HolidayModel> holidays = [];
  int _currentPage = 1;
  bool _hasNext = true;

  Future<void> getAllHolidays({bool loadMore = false}) async {
    if (state is GetAllHolidaysLoading ||
        state is PaginationLoading ||
        (loadMore && !_hasNext)) {
      return;
    }
    if (loadMore) {
      emit(PaginationLoading());
    } else {
      holidays.clear();
      _currentPage = 1;
      _hasNext = true;
      emit(GetAllHolidaysLoading());
    }
    final result = await _repository.getAllRequests(_currentPage);
    result.fold(
      (l) {
        emit(GetAllHolidaysError(error: l.message));
      },
      (r) {
        holidays.addAll(r.result?.vacations ?? []);
        _hasNext = r.result?.pagination?.hasNext ?? false;
        if (_hasNext) {
          _currentPage++;
        }
        emit(GetAllHolidaysLoaded());
        print("holidays.length ${holidays.length}");
      },
    );
  }

  /// =========================
  /// 🔹 CREATE (API)
  /// =========================
  Future<void> createHoliday({required HolidayRequest model}) async {
    emit(CreateHolidayLoading());

    final result = await _repository.createHolidayRequest(model);

    result.fold(
      (failure) {
        emit(CreateHolidayError(error: failure.message));
      },
      (response) async {
        emit(CreateHolidaySuccess());

        /// 🔄 Refresh list
        await getAllHolidays();
      },
    );
  }

  /// =========================
  /// =========================
  Future<void> deleteHoliday(int id) async {
    emit(DeleteHolidayLoading(id: id));

    final result = await _repository.deleteHoliday(id);

    result.fold(
      (failure) {
        emit(DeleteHolidayError(error: failure.message));
      },
      (response) async {
        emit(DeleteHolidaySuccess());

        await getAllHolidays(); // refresh
      },
    );
  }

  /// =========================
  Future<void> updateHoliday({
    required int id,
    required HolidayRequest model,
  }) async {
    emit(UpdateHolidayLoading(id: id));

    final result = await _repository.updateHoliday(id, model);

    result.fold(
      (failure) {
        emit(UpdateHolidayError(error: failure.message));
      },

      (response) async {
        emit(UpdateHolidaySuccess());

        await getAllHolidays();
      },
    );
  }
}
