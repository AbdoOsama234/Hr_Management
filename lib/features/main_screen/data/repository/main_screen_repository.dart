import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hr_manegement/core/network/error_handler.dart';
import 'package:hr_manegement/features/main_screen/data/models/daily_work_log.dart';
import 'package:hr_manegement/features/main_screen/data/models/employee_dashboard.dart';
import 'package:hr_manegement/core/storage/remote/dio_helper/dio_helper.dart';

@injectable
class MainScreenRepository {
  final DioHelper dioRequest;

  MainScreenRepository({required this.dioRequest});

  Future<Either<FailureException, EmployeeDashboard>> getDashboard() async {
    try {
      // Mock data for now
      final dashboard = EmployeeDashboard(
        employeeName: 'عبدالرحمن اسامه',
        jobTitle: 'Mobile Develober',
        avatar:
            'https://ui-avatars.com/api/?name=Abdelrahman+Osama&background=e50014&color=fff&size=200&bold=true',
        presentDays: 18,
        leaveDays: 3,
        lateHoursUsed: 2,
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
