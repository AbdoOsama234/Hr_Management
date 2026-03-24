enum MissionStatus { pending, approved, rejected }

enum MissionImportance { low, medium, high }

class MyMissionModel {
  final String id;
  DateTime date;
  String notes;
  MissionImportance importance;
  MissionStatus status;

  MyMissionModel({
    required this.id,
    required this.date,
    required this.notes,
    required this.importance,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'notes': notes,
      'importance': importance.index,
      'status': status.index,
    };
  }

  factory MyMissionModel.fromJson(Map<String, dynamic> json) {
    return MyMissionModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      notes: json['notes'],
      importance: MissionImportance.values[json['importance']],
      status: MissionStatus.values[json['status']],
    );
  }
}
