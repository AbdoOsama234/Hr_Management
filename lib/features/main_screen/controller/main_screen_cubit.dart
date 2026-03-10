import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:hr_manegement/data/models/employee_dashboard.dart';
import 'package:hr_manegement/data/repository/main_screen_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:hr_manegement/core/network/error_handler.dart';
import 'package:hr_manegement/data/models/daily_work_log.dart';
import 'package:hr_manegement/data/storage/remote/dio_helper/dio_helper.dart';

part 'main_screen_state.dart';

@injectable
class MainScreenCubit extends Cubit<MainScreenState> {
  final MainScreenRepository _repository;

  MainScreenCubit(this._repository) : super(MainScreenInitial());

  Future<void> loadDashboard() async {
    emit(MainScreenLoading());
    final result = await _repository.getDashboard();
    result.fold(
      (failure) => emit(MainScreenError(failure.message)),
      (dashboard) => emit(MainScreenLoaded(dashboard: dashboard)),
    );
  }
}
