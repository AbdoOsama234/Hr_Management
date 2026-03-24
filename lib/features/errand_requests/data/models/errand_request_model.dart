enum ErrandStatus { pending, approved, rejected }

class ErrandRequestModel {
  final String id;
  DateTime startDate;
  DateTime endDate;
  int days;
  String reason;
  ErrandStatus status;

  ErrandRequestModel({
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

  factory ErrandRequestModel.fromJson(Map<String, dynamic> json) {
    return ErrandRequestModel(
      id: json['id'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      days: (json['days'] as num).toInt(),
      reason: json['reason'],
      status: ErrandStatus.values[json['status']],
    );
  }
}

