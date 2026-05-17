import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/features/main_screen/data/models/employee_dashboard.dart';
import 'package:hr_manegement/features/main_screen/data/repository/main_screen_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'main_screen_state.dart';

@injectable
class MainScreenCubit extends Cubit<MainScreenState> {
  final MainScreenRepository _repository;
  static MainScreenCubit get(BuildContext context) =>
      context.read<MainScreenCubit>();
  MainScreenCubit(this._repository) : super(MainScreenInitial());




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
      emit(MainScreenLoaded(
        dashboard: currentState.dashboard.copyWith(
          isTaskCompleted: !currentState.dashboard.isTaskCompleted,
        ),
      ));
    }
  }
}