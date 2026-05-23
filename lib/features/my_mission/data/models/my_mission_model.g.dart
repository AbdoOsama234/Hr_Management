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
      desc: json['desc'] as String?,
      customerId: (json['customer_id'] as num?)?.toInt(),
      contactId: (json['contact_id'] as num?)?.toInt(),
      assignTo: (json['assign_to'] as num?)?.toInt(),
      companyId: (json['company_id'] as num?)?.toInt(),
      sectionId: (json['section_id'] as num?)?.toInt(),
      priorityId: (json['priority_id'] as num?)?.toInt(),
      link: json['link'] as String?,
      file: json['file'] as String?,
      dueDate: json['due_date'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      createdBy: (json['created_by'] as num?)?.toInt(),
      updatedBy: (json['updated_by'] as num?)?.toInt(),
      deletedBy: (json['deleted_by'] as num?)?.toInt(),
      deletedAt: (json['deleted_at'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      position: (json['position'] as num?)?.toInt(),
      taskStatusId: (json['task_status_id'] as num?)?.toInt(),
      teamId: (json['team_id'] as num?)?.toInt(),
      merchantId: (json['merchant_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MyMissionModelToJson(MyMissionModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'sr': ?instance.sr,
      'subject': ?instance.subject,
      'status': ?instance.status,
      'date': ?instance.date,
      'desc': ?instance.desc,
      'customer_id': ?instance.customerId,
      'contact_id': ?instance.contactId,
      'assign_to': ?instance.assignTo,
      'company_id': ?instance.companyId,
      'section_id': ?instance.sectionId,
      'priority_id': ?instance.priorityId,
      'link': ?instance.link,
      'file': ?instance.file,
      'due_date': ?instance.dueDate,
      'start_date': ?instance.startDate,
      'end_date': ?instance.endDate,
      'created_by': ?instance.createdBy,
      'updated_by': ?instance.updatedBy,
      'deleted_by': ?instance.deletedBy,
      'deleted_at': ?instance.deletedAt,
      'created_at': ?instance.createdAt,
      'updated_at': ?instance.updatedAt,
      'position': ?instance.position,
      'task_status_id': ?instance.taskStatusId,
      'team_id': ?instance.teamId,
      'merchant_id': ?instance.merchantId,
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
