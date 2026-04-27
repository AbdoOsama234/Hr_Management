import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/business_trip_requests/data/repository/business_trip_repository.dart';
import '../../../features/employee/data/repository/employee_repository.dart';

@module
abstract class DIModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker.instance;

  /// ✅ Employee
  EmployeeServiceClient getEmployeeService(Dio client) =>
      EmployeeServiceClient(client);

  /// ✅ Business Trip (ده اللي ناقص)
  BusinessTripServiceClient getBusinessTripService(Dio client) =>
      BusinessTripServiceClient(client);

  Key getKey() => UniqueKey();
}