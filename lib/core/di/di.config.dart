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

import '../../data/storage/local/app_prefs.dart' as _i74;
import '../../data/storage/remote/dio_helper/dio_helper.dart' as _i832;
import '../../features/business_trip_requests/controller/business_trip_cubit.dart'
    as _i765;
import '../../features/business_trip_requests/data/repository/business_trip_repository.dart'
    as _i508;
import '../../features/employee/controller/employee_cubit.dart' as _i222;
import '../../features/employee/data/datasource/employee_local_data_source.dart'
    as _i73;
import '../../features/employee/data/repository/employee_repository.dart'
    as _i611;
import '../../features/main_screen/controller/main_screen_cubit.dart' as _i97;
import '../../features/main_screen/data/repository/main_screen_repository.dart'
    as _i984;
import '../app_cubit/app_cubit.dart' as _i962;
import '../network/network_info.dart' as _i932;
import '../network/save_api.dart' as _i871;
import 'module/di_module.dart' as _i495;
import 'module/dio_module.dart' as _i556;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final dIModule = _$DIModule();
  final dioModule = _$DioModule();
  gh.factory<_i73.EmployeeLocalDataSourceImpl>(
    () => _i73.EmployeeLocalDataSourceImpl(),
  );
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => dIModule.prefs,
    preResolve: true,
  );
  gh.factory<_i973.InternetConnectionChecker>(() => dIModule.connectionChecker);
  gh.factory<_i409.Key>(() => dIModule.getKey());
  gh.factory<_i932.NetworkInfo>(
    () => _i932.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()),
  );
  gh.singleton<_i74.AppPreferences>(
    () => _i74.AppPreferences(gh<_i460.SharedPreferences>()),
  );
  gh.singleton<_i962.AppCubit>(() => _i962.AppCubit(gh<_i74.AppPreferences>()));
  gh.singleton<_i832.DioHelper>(
    () => _i832.DioHelper(gh<_i74.AppPreferences>()),
  );
  gh.factory<_i871.SafeApi>(() => _i871.SafeApi(gh<_i932.NetworkInfo>()));
  gh.factory<_i984.MainScreenRepository>(
    () => _i984.MainScreenRepository(dioRequest: gh<_i832.DioHelper>()),
  );
  await gh.factoryAsync<_i361.Dio>(
    () => dioModule.getDio(gh<_i74.AppPreferences>()),
    preResolve: true,
  );
  gh.factory<_i611.EmployeeServiceClient>(
    () => dIModule.getEmployeeService(gh<_i361.Dio>()),
  );
  gh.factory<_i508.BusinessTripServiceClient>(
    () => dIModule.getBusinessTripService(gh<_i361.Dio>()),
  );
  gh.factory<_i611.EmployeeRepository>(
    () => _i611.EmployeeRepository(
      gh<_i611.EmployeeServiceClient>(),
      gh<_i871.SafeApi>(),
    ),
  );
  gh.factory<_i97.MainScreenCubit>(
    () => _i97.MainScreenCubit(gh<_i984.MainScreenRepository>()),
  );
  gh.factory<_i222.EmployeeCubit>(
    () => _i222.EmployeeCubit(gh<_i611.EmployeeRepository>()),
  );
  gh.factory<_i508.BusinessTripRepository>(
    () => _i508.BusinessTripRepository(
      gh<_i508.BusinessTripServiceClient>(),
      gh<_i871.SafeApi>(),
    ),
  );
  gh.factory<_i765.BusinessTripCubit>(
    () => _i765.BusinessTripCubit(gh<_i508.BusinessTripRepository>()),
  );
  return getIt;
}

class _$DIModule extends _i495.DIModule {}

class _$DioModule extends _i556.DioModule {}
