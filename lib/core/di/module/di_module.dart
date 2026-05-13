import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/features/holiday__requests/data/repository/holiday_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/data/repository/auth_repository.dart';
import '../../../features/business_trip_requests/data/repository/business_trip_repository.dart';
import '../../../features/employee/data/repository/employee_repository.dart';
import '../../../features/errand_requests/data/repository/errand_repository.dart';
import '../../../features/loan__requests/data/repository/loan_repository.dart';
import '../../../features/permission_request/data/service/permission_service.dart';
import '../../../features/my_mission/data/service/my_mission_service.dart';

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

  /// ✅ Errand Request
  ErrandServiceClient getErrandService(Dio client) =>
      ErrandServiceClient(client);

  /// ✅ loan Request
  LoanServiceClient getloanService(Dio client) => LoanServiceClient(client);

  /// ✅ holiday Request
  HolidayServiceClient getHolidayService(Dio client) =>
      HolidayServiceClient(client);

  /// ✅ Permission Request
  PermissionServiceClient getPermissionService(Dio client) =>
      PermissionServiceClient(client);

  /// ✅ My Mission (Tasks)
  MyMissionServiceClient getMyMissionService(Dio client) =>
      MyMissionServiceClient(client);

  ///Auth
  AuthServiceClient getAuthService(Dio client) => AuthServiceClient(client);

  Key getKey() => UniqueKey();
}
