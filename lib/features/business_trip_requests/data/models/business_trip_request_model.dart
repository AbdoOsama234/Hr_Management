enum BusinessTripStatus { pending, approved, rejected }

class BusinessTripRequestModel {
  final String id;
  DateTime startDate;
  DateTime endDate;
  int days;
  String reason;
  BusinessTripStatus status;

  BusinessTripRequestModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.days,
    required this.reason,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'days': days,
      'reason': reason,
      'status': status.index,
    };
  }

  factory BusinessTripRequestModel.fromJson(Map<String, dynamic> json) {
    return BusinessTripRequestModel(
      id: json['id'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      days: (json['days'] as num).toInt(),
      reason: json['reason'],
      status: BusinessTripStatus.values[json['status']],
    );
  }
}
