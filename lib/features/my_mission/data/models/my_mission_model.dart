import 'package:json_annotation/json_annotation.dart';
import '../../../../data/models/pagination_model.dart';

part 'my_mission_model.g.dart';

/// 🔹 Single Task Item
@JsonSerializable()
class MyMissionModel {
  int? id;
  String? sr;
  String? subject;
  String? status;
  String? date;
  @JsonKey(name: 'due_date')
  String? dueDate;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;
  @JsonKey(name: 'priority_id')
  int? priorityId;
  @JsonKey(name: 'task_status_id')
  int? taskStatusId;

  MyMissionModel({
    this.id,
    this.sr,
    this.subject,
    this.status,
    this.date,
    this.dueDate,
    this.startDate,
    this.endDate,
    this.priorityId,
    this.taskStatusId,
  });

  factory MyMissionModel.fromJson(Map<String, dynamic> json) =>
      _$MyMissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyMissionModelToJson(this);
}

/// 🔹 Wrapper (GET all)
@JsonSerializable()
class AllMyMissions {
  Pagination? pagination;
  List<MyMissionModel>? tasks;

  AllMyMissions({this.pagination, this.tasks});

  factory AllMyMissions.fromJson(Map<String, dynamic> json) =>
      _$AllMyMissionsFromJson(json);

  Map<String, dynamic> toJson() => _$AllMyMissionsToJson(this);
}
