enum PermissionStatus { pending, approved, rejected }

class PermissionRequestModel {
  final String id;
  DateTime startDate;
  DateTime endDate;
  double hours;
  String reason;
  PermissionStatus status;

  PermissionRequestModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.hours,
    required this.reason,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'hours': hours,
      'reason': reason,
      'status': status.index,
    };
  }

  factory PermissionRequestModel.fromJson(Map<String, dynamic> json) {
    return PermissionRequestModel(
      id: json['id'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      hours: (json['hours'] as num).toDouble(),
      reason: json['reason'],
      status: PermissionStatus.values[json['status']],
    );
  }
}
