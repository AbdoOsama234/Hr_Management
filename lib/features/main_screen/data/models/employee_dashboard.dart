import 'daily_work_log.dart';

class EmployeeDashboard {
  final String employeeName;
  final String jobTitle;
  final String avatar;
  final int presentDays;
  final int leaveDays;
  final double lateHoursUsed;
  final double lateHoursAllowed;
  final List<DailyWorkLog> weeklyReport;

  EmployeeDashboard({
    required this.employeeName,
    required this.jobTitle,
    required this.avatar,
    required this.presentDays,
    required this.leaveDays,
    required this.lateHoursUsed,
    required this.lateHoursAllowed,
    required this.weeklyReport,
  });

  factory EmployeeDashboard.fromJson(Map<String, dynamic> json) {
    return EmployeeDashboard(
      employeeName: json['employeeName'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      avatar: json['avatar'] ?? '',
      presentDays: json['presentDays'] ?? 0,
      leaveDays: json['leaveDays'] ?? 0,
      lateHoursUsed: (json['lateHoursUsed'] ?? 0.0).toDouble(),
      lateHoursAllowed: (json['lateHoursAllowed'] ?? 0.0).toDouble(),
      weeklyReport: (json['weeklyReport'] as List? ?? [])
          .map((e) => DailyWorkLog.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeName': employeeName,
      'jobTitle': jobTitle,
      'avatar': avatar,
      'presentDays': presentDays,
      'leaveDays': leaveDays,
      'lateHoursUsed': lateHoursUsed,
      'lateHoursAllowed': lateHoursAllowed,
      'weeklyReport': weeklyReport.map((e) => e.toJson()).toList(),
    };
  }
}
