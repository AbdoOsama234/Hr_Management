import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/data/repository/auth_repository.dart';
import '../../../features/business_trip_requests/data/repository/business_trip_repository.dart';
import '../../../features/employee/data/repository/employee_repository.dart';
import '../../../features/errand_requests/data/repository/errand_repository.dart';

@module
abstract class DIModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker.instance;

  /// ✅ Employee
  EmployeeServiceClient getEmployeeService(Dio client) =>
      EmployeeServiceClient(client);

  /// ✅ Business Trip
  BusinessTripServiceClient getBusinessTripService(Dio client) =>
      BusinessTripServiceClient(client);

  /// ✅ Business Trip
  ErrandServiceClient getErrandService(Dio client) =>
      ErrandServiceClient(client);

  AuthServiceClient getAuthService(Dio client) => AuthServiceClient(client);

  Key getKey() => UniqueKey();
}
