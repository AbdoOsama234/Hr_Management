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

import '../../data/repository/app_repo/app_repo.dart' as _i747;
import '../../data/repository/main_screen_repository.dart' as _i402;
import '../../data/repository/repository_employee/employee_repository.dart'
    as _i1002;
import '../../data/repository/repository_employee/flat_repository.dart'
    as _i745;
import '../../data/repository/repository_employee/notification_repo.dart'
    as _i925;
import '../../data/repository/repository_employee/profile_repo.dart' as _i810;
import '../../data/repository/repository_owner/aqaraty_repo/real_estate_repo_impl.dart'
    as _i318;
import '../../data/repository/repository_owner/auth/auth_repository.dart'
    as _i670;
import '../../data/repository/repository_owner/customer_service/customer_service_repo_impl.dart'
    as _i1066;
import '../../data/repository/repository_owner/employees_repo/employees_repo_impl.dart'
    as _i275;
import '../../data/repository/repository_owner/flats_repo/flats_repo_impl.dart'
    as _i349;
import '../../data/repository/repository_owner/notification_repo/notification_repo.dart'
    as _i822;
import '../../data/repository/repository_owner/on_boarding_repo/on_boarding_repo_impl.dart'
    as _i629;
import '../../data/repository/repository_owner/profile/profile_repo.dart'
    as _i108;
import '../../data/storage/local/app_prefs.dart' as _i74;
import '../../data/storage/remote/dio_helper/dio_helper.dart' as _i832;
import '../../features/language/controller/language_cubit.dart' as _i247;
import '../../features/main_screen/controller/main_screen_cubit.dart' as _i97;
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
  gh.singleton<_i247.LanguageCubit>(
    () => _i247.LanguageCubit(gh<_i74.AppPreferences>()),
  );
  gh.factory<_i402.MainScreenRepository>(
    () => _i402.MainScreenRepository(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.factory<_i1002.EmployeeRepository>(
    () => _i1002.EmployeeRepository(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.factory<_i745.FlatRepository>(
    () => _i745.FlatRepository(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.factory<_i925.NotificationRepo>(
    () => _i925.NotificationRepo(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.factory<_i822.NotificationRepo>(
    () => _i822.NotificationRepo(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.singleton<_i747.AppRepo>(
    () => _i747.AppRepo(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.singleton<_i810.ProfileRepo>(
    () => _i810.ProfileRepo(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.singleton<_i318.RealEstateRepo>(
    () => _i318.RealEstateRepo(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.singleton<_i670.AuthRepository>(
    () => _i670.AuthRepository(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.singleton<_i1066.CustomServiceRepo>(
    () => _i1066.CustomServiceRepo(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.singleton<_i275.EmployeesRepo>(
    () => _i275.EmployeesRepo(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.singleton<_i349.FlatsRepo>(
    () => _i349.FlatsRepo(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.singleton<_i629.OnBoardingRepo>(
    () => _i629.OnBoardingRepo(dioRequest: gh<_i832.DioHelper>()),
  );
  gh.singleton<_i108.ProfileRepo>(
    () => _i108.ProfileRepo(dioRequest: gh<_i832.DioHelper>()),
  );
  await gh.factoryAsync<_i361.Dio>(
    () => dioModule.getDio(gh<_i74.AppPreferences>()),
    preResolve: true,
  );
  gh.factory<_i97.MainScreenCubit>(
    () => _i97.MainScreenCubit(gh<_i402.MainScreenRepository>()),
  );
  return getIt;
}

class _$DIModule extends _i495.DIModule {}

class _$DioModule extends _i556.DioModule {}
