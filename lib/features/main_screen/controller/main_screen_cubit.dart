import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/data/storage/local/app_prefs.dart';
import 'package:hr_manegement/features/main_screen/data/models/attendance_model.dart';
import 'package:hr_manegement/features/main_screen/data/repository/main_screen_repository.dart';
import 'main_screen_state.dart';

export 'main_screen_state.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  final MainScreenRepository _repository;

  static MainCubit get(BuildContext context) => context.read<MainCubit>();

  MainCubit(this._repository) : super(MainInitial());

  /// 📥 DATA
  AttendanceModel? attendance;

  /// =========================
  /// 🔹 GET ATTENDANCE (API)
  /// =========================
  Future<void> getAttendance() async {
    emit(GetAttendanceLoading());

    final employeeId =
        getIt<AppPreferences>().loadUserData?.employeesId ??
        0; // fallback to 488 if null

    final result = await _repository.getAttendance(employeeId);

    result.fold(
      (failure) {
        emit(GetAttendanceError(error: failure.message));
      },
      (response) {
        attendance = response.result;
        emit(GetAttendanceSuccess(attendance: response.result));
      },
    );
  }

  /// =========================
  /// 🔹 DASHBOARD (Keep existing)
  /// =========================
  Future<void> loadDashboard() async {
    emit(MainScreenLoading());
    final result = await _repository.getDashboard();
    result.fold(
      (failure) => emit(MainScreenError(failure.message)),
      (dashboard) => emit(MainScreenLoaded(dashboard: dashboard)),
    );
  }

  void toggleTaskCompletion() {
    final currentState = state;
    if (currentState is MainScreenLoaded) {
      emit(
        MainScreenLoaded(
          dashboard: currentState.dashboard.copyWith(
            isTaskCompleted: !currentState.dashboard.isTaskCompleted,
          ),
        ),
      );
    }
  }
}
