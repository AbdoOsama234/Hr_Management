import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../core/api_urls.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/network/save_api.dart';
import '../../../../data/models/base_response.dart';

import 'package:retrofit/error_logger.dart';

import '../../../../data/storage/remote/dio_helper/dio_helper.dart';
import '../models/attendance_model.dart';
import '../models/daily_work_log.dart';
import '../models/employee_dashboard.dart';

part 'main_screen_repository.g.dart';


@RestApi(baseUrl: ApiUrls.baseApiUrl)
abstract class MainScreenServiceClient {
  factory MainScreenServiceClient(Dio dio, {String baseUrl}) =
  _MainScreenServiceClient;


  @GET(ApiUrls.employeeAttendance)
  Future<BaseResponse<AttendanceModel>> getAttendance(@Path("id") int id,);

}

/// =========================
/// 🔹 REPOSITORY
/// =========================
@injectable
class MainScreenRepository {
  final MainScreenServiceClient _service;
  final SafeApi _safeApi;
  final DioHelper dioRequest;


  MainScreenRepository(this._service, this._safeApi,this.dioRequest);

  /// 📥 Get all
  Future<Either<Failure, BaseResponse<AttendanceModel>>> getAttendance(
      int id,
      ) async {
    return await _safeApi.call(apiCall: _service.getAttendance(id));
  }



  ///FackData
  Future<Either<FailureException, EmployeeDashboard>> getDashboard() async {
    try {
      // Mock data for now
      final dashboard = EmployeeDashboard(
        employeeName: 'عبدالرحمن اسامه',
        jobTitle: 'Mobile Develober',
        // avatar:
        // 'https://ui-avatars.com/api/?name=Abdelrahman+Osama&background=1C1C1E&color=C362D8&size=200',
        presentDays: 18,
        leaveDays: 3,
        lateHoursUsed: 6,
        lateHoursAllowed: 6,
        weeklyReport: [
          DailyWorkLog(
            day: 'السبت',
            checkIn: '09:55',
            checkOut: '06:00',
            workHours: '8h 05m',
            lateMinutes: '0m',
            status: 'Done',
          ),
          DailyWorkLog(
            day: 'الاحد',
            checkIn: '09:05',
            checkOut: '06:10',
            workHours: '8h 05m',
            lateMinutes: '5m',
            status: 'Done',
          ),
          DailyWorkLog(
            day: 'الاثنين',
            checkIn: '09:58',
            checkOut: '06:15',
            workHours: '8h 17m',
            lateMinutes: '0m',
            status: 'Done',
          ),
          DailyWorkLog(
            day: 'الثلاثاء',
            checkIn: '10:20',
            checkOut: '06:30',
            workHours: '8h 10m',
            lateMinutes: '20m',
            status: 'Done',
          ),
          DailyWorkLog(
            day: 'الاربعاء',
            checkIn: '010:00',
            checkOut: '06:00',
            workHours: '8h 00m',
            lateMinutes: '0m',
            status: 'Done',
          ),
        ],
      );

      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Simulate network
      return Right(dashboard);
    } catch (e) {
      return Left(ServerFailure("Failed to load dashboard data"));
    }
  }

}
