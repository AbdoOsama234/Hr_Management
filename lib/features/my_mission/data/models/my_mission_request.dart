import 'package:json_annotation/json_annotation.dart';

part 'my_mission_request.g.dart';

/// 🔹 Update Task Request Body
@JsonSerializable()
class MyMissionRequest {
  @JsonKey(name: 'task_status_id')
  int? taskStatusId;
  @JsonKey(name: 'priority_id')
  int? priorityId;

  MyMissionRequest({
    this.taskStatusId,
    this.priorityId,
  });

  factory MyMissionRequest.fromJson(Map<String, dynamic> json) =>
      _$MyMissionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MyMissionRequestToJson(this);
}
