// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'errand_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrandRequest _$ErrandRequestFromJson(Map<String, dynamic> json) =>
    ErrandRequest(
      requestDate: json['request_date'] as String?,
      tripType: json['trip_type'] as String?,
      employeesId: json['employees_id'] as String?,
      alternateEmployeeId: json['alternate_employee_id'] as String?,
      managementId: json['management_id'] as String?,
      branchesId: (json['branches_id'] as num?)?.toInt(),
      fromDate: json['from_date'] as String?,
      toDate: json['to_date'] as String?,
      daysCount: (json['days_count'] as num?)?.toInt(),
      status: json['status'] as String?,
      requestNotes: json['request_notes'] as String?,
      statusNotes: json['status_notes'] as String?,
      createdBy: (json['created_by'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ErrandRequestToJson(ErrandRequest instance) =>
    <String, dynamic>{
      'request_date': ?instance.requestDate,
      'trip_type': ?instance.tripType,
      'employees_id': ?instance.employeesId,
      'alternate_employee_id': ?instance.alternateEmployeeId,
      'management_id': ?instance.managementId,
      'branches_id': ?instance.branchesId,
      'from_date': ?instance.fromDate,
      'to_date': ?instance.toDate,
      'days_count': ?instance.daysCount,
      'status': ?instance.status,
      'request_notes': ?instance.requestNotes,
      'status_notes': ?instance.statusNotes,
      'created_by': ?instance.createdBy,
    };
