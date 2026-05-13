// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_mission_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyMissionDetailsModel _$MyMissionDetailsModelFromJson(
  Map<String, dynamic> json,
) => MyMissionDetailsModel(
  id: (json['id'] as num?)?.toInt(),
  sr: json['sr'] as String?,
  subject: json['subject'] as String?,
  desc: json['desc'] as String?,
  assignTo: (json['assign_to'] as num?)?.toInt(),
  priorityId: (json['priority_id'] as num?)?.toInt(),
  dueDate: json['due_date'] as String?,
  startDate: json['start_date'] as String?,
  endDate: json['end_date'] as String?,
  taskStatusId: (json['task_status_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$MyMissionDetailsModelToJson(
  MyMissionDetailsModel instance,
) => <String, dynamic>{
  'id': ?instance.id,
  'sr': ?instance.sr,
  'subject': ?instance.subject,
  'desc': ?instance.desc,
  'assign_to': ?instance.assignTo,
  'priority_id': ?instance.priorityId,
  'due_date': ?instance.dueDate,
  'start_date': ?instance.startDate,
  'end_date': ?instance.endDate,
  'task_status_id': ?instance.taskStatusId,
};
