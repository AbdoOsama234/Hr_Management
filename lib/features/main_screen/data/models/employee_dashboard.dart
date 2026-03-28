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
  final bool isTaskCompleted;

  EmployeeDashboard({
    required this.employeeName,
    required this.jobTitle,
    required this.avatar,
    required this.presentDays,
    required this.leaveDays,
    required this.lateHoursUsed,
    required this.lateHoursAllowed,
    required this.weeklyReport,
    this.isTaskCompleted = false,
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
      isTaskCompleted: json['isTaskCompleted'] ?? false,
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
      'isTaskCompleted': isTaskCompleted,
    };
  }

  EmployeeDashboard copyWith({
    String? employeeName,
    String? jobTitle,
    String? avatar,
    int? presentDays,
    int? leaveDays,
    double? lateHoursUsed,
    double? lateHoursAllowed,
    List<DailyWorkLog>? weeklyReport,
    bool? isTaskCompleted,
  }) {
    return EmployeeDashboard(
      employeeName: employeeName ?? this.employeeName,
      jobTitle: jobTitle ?? this.jobTitle,
      avatar: avatar ?? this.avatar,
      presentDays: presentDays ?? this.presentDays,
      leaveDays: leaveDays ?? this.leaveDays,
      lateHoursUsed: lateHoursUsed ?? this.lateHoursUsed,
      lateHoursAllowed: lateHoursAllowed ?? this.lateHoursAllowed,
      weeklyReport: weeklyReport ?? this.weeklyReport,
      isTaskCompleted: isTaskCompleted ?? this.isTaskCompleted,
    );
  }
}
