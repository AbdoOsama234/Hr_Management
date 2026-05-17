class DailyWorkLog {
  final String day;
  final String checkIn;
  final String checkOut;
  final String workHours;
  final String lateMinutes;
  final String status;

  DailyWorkLog({
    required this.day,
    required this.checkIn,
    required this.checkOut,
    required this.workHours,
    required this.lateMinutes,
    required this.status,
  });

  factory DailyWorkLog.fromJson(Map<String, dynamic> json) {
    return DailyWorkLog(
      day: json['day'] ?? '',
      checkIn: json['checkIn'] ?? '',
      checkOut: json['checkOut'] ?? '',
      workHours: json['workHours'] ?? '',
      lateMinutes: json['lateMinutes'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'workHours': workHours,
      'lateMinutes': lateMinutes,
      'status': status,
    };
  }
}


