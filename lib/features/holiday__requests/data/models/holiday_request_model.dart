enum HolidayStatus { pending, approved, rejected }

class HolidayRequestModel {
  final String id;
  DateTime startDate;
  DateTime endDate;
  String reason;
  HolidayStatus status;

  HolidayRequestModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'reason': reason,
      'status': status.index,
    };
  }

  factory HolidayRequestModel.fromJson(Map<String, dynamic> json) {
    return HolidayRequestModel(
      id: json['id'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      reason: json['reason'],
      status: HolidayStatus.values[json['status']],
    );
  }
}
