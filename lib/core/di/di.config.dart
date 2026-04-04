// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/material.dart' as _i409;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/main_screen/controller/main_screen_cubit.dart' as _i97;
import '../../features/main_screen/data/repository/main_screen_repository.dart'
    as _i984;
import '../app_cubit/app_cubit.dart' as _i962;
import '../network/network_info.dart' as _i932;
import '../network/save_api.dart' as _i871;
import '../storage/local/app_prefs.dart' as _i15;
import '../storage/remote/dio_helper/dio_helper.dart' as _i327;
import 'module/di_module.dart' as _i495;
import 'module/dio_module.dart' as _i556;
import '../../features/employee/data/datasource/employee_local_data_source.dart' as _i101;
import '../../features/employee/data/repository/employee_repository.dart' as _i102;
import '../../features/employee/controller/employee_cubit.dart' as _i103;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final dIModule = _$DIModule();
  final dioModule = _$DioModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => dIModule.prefs,
    preResolve: true,
  );
  gh.factory<_i973.InternetConnectionChecker>(() => dIModule.connectionChecker);
  gh.factory<_i409.Key>(() => dIModule.getKey());
  gh.factory<_i932.NetworkInfo>(
    () => _i932.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()),
  );
  gh.singleton<_i15.AppPreferences>(
    () => _i15.AppPreferences(gh<_i460.SharedPreferences>()),
  );
  gh.factory<_i871.SafeApi>(() => _i871.SafeApi(gh<_i932.NetworkInfo>()));
  await gh.factoryAsync<_i361.Dio>(
    () => dioModule.getDio(gh<_i15.AppPreferences>()),
    preResolve: true,
  );
  gh.singleton<_i962.AppCubit>(() => _i962.AppCubit(gh<_i15.AppPreferences>()));
  gh.singleton<_i327.DioHelper>(
    () => _i327.DioHelper(gh<_i15.AppPreferences>()),
  );
  gh.factory<_i984.MainScreenRepository>(
    () => _i984.MainScreenRepository(dioRequest: gh<_i327.DioHelper>()),
  );
  gh.factory<_i97.MainScreenCubit>(
    () => _i97.MainScreenCubit(gh<_i984.MainScreenRepository>()),
  );
  gh.factory<_i101.EmployeeLocalDataSource>(() => _i101.EmployeeLocalDataSourceImpl());
  gh.factory<_i102.EmployeeRepository>(
    () => _i102.EmployeeRepositoryImpl(gh<_i101.EmployeeLocalDataSource>()),
  );
  gh.factory<_i103.EmployeeCubit>(
    () => _i103.EmployeeCubit(gh<_i102.EmployeeRepository>()),
  );
  return getIt;
}

class _$DIModule extends _i495.DIModule {}

class _$DioModule extends _i556.DioModule {}
