import 'package:json_annotation/json_annotation.dart';

part 'my_mission_details_model.g.dart';

/// 🔹 Task Details
@JsonSerializable()
class MyMissionDetailsModel {
  int? id;
  String? sr;
  String? subject;
  String? desc;
  @JsonKey(name: 'assign_to')
  int? assignTo;
  @JsonKey(name: 'priority_id')
  int? priorityId;
  @JsonKey(name: 'due_date')
  String? dueDate;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;
  @JsonKey(name: 'task_status_id')
  int? taskStatusId;

  MyMissionDetailsModel({
    this.id,
    this.sr,
    this.subject,
    this.desc,
    this.assignTo,
    this.priorityId,
    this.dueDate,
    this.startDate,
    this.endDate,
    this.taskStatusId,
  });

  factory MyMissionDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MyMissionDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyMissionDetailsModelToJson(this);
}
