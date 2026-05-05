import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../data/models/business_trip_model.dart';
import '../data/models/business_trip_request.dart';
import '../data/repository/business_trip_repository.dart';
import 'business_trip_state.dart';

@injectable
class BusinessTripCubit extends Cubit<BusinessTripState> {
  final BusinessTripRepository _repository;

  static BusinessTripCubit get(BuildContext context) =>
      context.read<BusinessTripCubit>();

  BusinessTripCubit(this._repository) : super(BusinessTripInitial());

  /// 📥 DATA
  List<BusinessTripModel> trips = [];
  int _currentPage = 1;
  bool _hasNext = true;

  Future<void> getAllTrips({bool loadMore = false}) async {
    if (state is GetAllTripsLoading ||
        state is PaginationLoading ||
        (loadMore && !_hasNext)) {
      return;
    }
    if (loadMore) {
      emit(PaginationLoading());
    } else {
      trips.clear();
      _currentPage = 1;
      _hasNext = true;
      emit(GetAllTripsLoading());
    }
    final result = await _repository.getAllRequests(_currentPage);
    result.fold(
      (l) {
        emit(GetAllTripsError(error: l.message));
      },
      (r) {
        trips.addAll(r.result?.trips ?? []);
        _hasNext = r.result?.pagination?.hasNext ?? false;
        if (_hasNext) {
          _currentPage++;
        }
        emit(GetAllTripsLoaded());
        print("trips.length ${trips.length}");
      },
    );
  }

  /// =========================
  /// 🔹 CREATE (API)
  /// =========================
  Future<void> createTrip({required BusinessTripRequest model}) async {
    emit(CreateTripLoading());

    final result = await _repository.createTripRequest(model);

    result.fold(
      (failure) {
        emit(CreateTripError(error: failure.message));
      },
      (response) async {
        emit(CreateTripSuccess());

        /// 🔄 Refresh list
        await getAllTrips();
      },
    );
  }

  /// =========================
  /// =========================
  Future<void> deleteTrip(int id) async {
    emit(DeleteTripLoading());

    final result = await _repository.deleteTrip(id);

    result.fold(
      (failure) {
        emit(DeleteTripError(error: failure.message));
      },
      (response) async {
        emit(DeleteTripSuccess());

        await getAllTrips(); // refresh
      },
    );
  }

  /// =========================
  void updateTrip({
    required int id,
    required String tripType,
    required DateTime fromDate,
    required DateTime toDate,
    required int days,
    required String reason,
  }) {
    final index = trips.indexWhere((trip) => trip.id == id);

    if (index != -1) {
      final oldTrip = trips[index];

      trips[index] = BusinessTripModel(
        id: id,
        tripType: tripType,
        fromDate: _formatDate(fromDate),
        toDate: _formatDate(toDate),
        daysCount: days,
        requestNotes: reason,
        status: oldTrip.status,
        createdAt: oldTrip.createdAt,
        updatedAt: oldTrip.updatedAt,
      );

      emit(GetAllTripsLoaded());
    }
  }

  /// =========================
  /// 🔹 Helpers
  /// =========================
  String _formatDate(DateTime date) {
    return date.toString().split(' ').first;
  }
}
