// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_mission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyMissionModel _$MyMissionModelFromJson(Map<String, dynamic> json) =>
    MyMissionModel(
      id: (json['id'] as num?)?.toInt(),
      sr: json['sr'] as String?,
      subject: json['subject'] as String?,
      status: json['status'] as String?,
      date: json['date'] as String?,
      dueDate: json['due_date'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      priorityId: (json['priority_id'] as num?)?.toInt(),
      taskStatusId: (json['task_status_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MyMissionModelToJson(MyMissionModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'sr': ?instance.sr,
      'subject': ?instance.subject,
      'status': ?instance.status,
      'date': ?instance.date,
      'due_date': ?instance.dueDate,
      'start_date': ?instance.startDate,
      'end_date': ?instance.endDate,
      'priority_id': ?instance.priorityId,
      'task_status_id': ?instance.taskStatusId,
    };

AllMyMissions _$AllMyMissionsFromJson(Map<String, dynamic> json) =>
    AllMyMissions(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => MyMissionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllMyMissionsToJson(AllMyMissions instance) =>
    <String, dynamic>{
      'pagination': ?instance.pagination?.toJson(),
      'tasks': ?instance.tasks?.map((e) => e.toJson()).toList(),
    };
