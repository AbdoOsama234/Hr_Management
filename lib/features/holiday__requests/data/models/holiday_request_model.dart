enum HolidayStatus {
  pending,
  approved,
  rejected,
}

class HolidayRequestModel {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final HolidayStatus status;

  HolidayRequestModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
  });

  HolidayRequestModel copyWith({
    String? id,
    DateTime? startDate,
    DateTime? endDate,
    String? reason,
    HolidayStatus? status,
  }) {
    return HolidayRequestModel(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reason: reason ?? this.reason,
      status: status ?? this.status,
    );
  }
}
