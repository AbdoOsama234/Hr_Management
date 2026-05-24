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
  status: json['status'] as String?,
  date: json['date'] as String?,
  desc: json['desc'] as String?,
  customerId: json['customer_id'] as String?,
  contactId: json['contact_id'] as String?,
  assignTo: (json['assign_to'] as num?)?.toInt(),
  companyId: (json['company_id'] as num?)?.toInt(),
  sectionId: json['section_id'] as String?,
  priorityId: (json['priority_id'] as num?)?.toInt(),
  link: json['link'] as String?,
  file: json['file'] as String?,
  dueDate: json['due_date'] as String?,
  startDate: json['start_date'] as String?,
  endDate: json['end_date'] as String?,
  position: (json['position'] as num?)?.toInt(),
  taskStatusId: (json['task_status_id'] as num?)?.toInt(),
  teamId: (json['team_id'] as num?)?.toInt(),
  merchantId: (json['merchant_id'] as num?)?.toInt(),
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$MyMissionDetailsModelToJson(
  MyMissionDetailsModel instance,
) => <String, dynamic>{
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
  'position': ?instance.position,
  'task_status_id': ?instance.taskStatusId,
  'team_id': ?instance.teamId,
  'merchant_id': ?instance.merchantId,
  'created_at': ?instance.createdAt,
};
