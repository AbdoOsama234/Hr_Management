// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissionModel _$PermissionModelFromJson(Map<String, dynamic> json) =>
    PermissionModel(
      id: (json['id'] as num?)?.toInt(),
      companyId: (json['company_id'] as num?)?.toInt(),
      requestNumber: json['request_number'] as String?,
      branchesId: (json['branches_id'] as num?)?.toInt(),
      requestDate: json['request_date'] as String?,
      type: json['type'] as String?,
      employeesId: (json['employees_id'] as num?)?.toInt(),
      substituteEmployeeId: (json['substitute_employee_id'] as num?)?.toInt(),
      managementId: (json['management_id'] as num?)?.toInt(),
      fromDatetime: json['from_datetime'] as String?,
      toDatetime: json['to_datetime'] as String?,
      hours: json['hours'] as String?,
      status: json['status'] as String?,
      requestNotes: json['request_notes'] as String?,
      statusNotes: json['status_notes'] as String?,
    );

Map<String, dynamic> _$PermissionModelToJson(PermissionModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'company_id': ?instance.companyId,
      'request_number': ?instance.requestNumber,
      'branches_id': ?instance.branchesId,
      'request_date': ?instance.requestDate,
      'type': ?instance.type,
      'employees_id': ?instance.employeesId,
      'substitute_employee_id': ?instance.substituteEmployeeId,
      'management_id': ?instance.managementId,
      'from_datetime': ?instance.fromDatetime,
      'to_datetime': ?instance.toDatetime,
      'hours': ?instance.hours,
      'status': ?instance.status,
      'request_notes': ?instance.requestNotes,
      'status_notes': ?instance.statusNotes,
    };
