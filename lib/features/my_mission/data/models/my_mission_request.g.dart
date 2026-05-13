// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_mission_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyMissionRequest _$MyMissionRequestFromJson(Map<String, dynamic> json) =>
    MyMissionRequest(
      taskStatusId: (json['task_status_id'] as num?)?.toInt(),
      priorityId: (json['priority_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MyMissionRequestToJson(MyMissionRequest instance) =>
    <String, dynamic>{
      'task_status_id': ?instance.taskStatusId,
      'priority_id': ?instance.priorityId,
    };
