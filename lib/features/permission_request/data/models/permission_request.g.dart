// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissionRequest _$PermissionRequestFromJson(Map<String, dynamic> json) =>
    PermissionRequest(
      branchesId: (json['branches_id'] as num?)?.toInt(),
      employeesId: (json['employees_id'] as num?)?.toInt(),
      substituteEmployeeId: (json['substitute_employee_id'] as num?)?.toInt(),
      requestDate: json['request_date'] as String?,
      type: json['type'] as String?,
      fromDatetime: json['from_datetime'] as String?,
      toDatetime: json['to_datetime'] as String?,
      hours: json['hours'] as String?,
      status: json['status'] as String?,
      requestNotes: json['request_notes'] as String?,
      statusNotes: json['status_notes'] as String?,
      createdBy: (json['created_by'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PermissionRequestToJson(PermissionRequest instance) =>
    <String, dynamic>{
      'branches_id': ?instance.branchesId,
      'employees_id': ?instance.employeesId,
      'substitute_employee_id': ?instance.substituteEmployeeId,
      'request_date': ?instance.requestDate,
      'type': ?instance.type,
      'from_datetime': ?instance.fromDatetime,
      'to_datetime': ?instance.toDatetime,
      'hours': ?instance.hours,
      'status': ?instance.status,
      'request_notes': ?instance.requestNotes,
      'status_notes': ?instance.statusNotes,
      'created_by': ?instance.createdBy,
    };
