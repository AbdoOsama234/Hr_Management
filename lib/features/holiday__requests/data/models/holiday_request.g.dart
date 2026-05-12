// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HolidayRequest _$HolidayRequestFromJson(Map<String, dynamic> json) =>
    HolidayRequest(
      branchesId: (json['branches_id'] as num?)?.toInt(),
      employeesId: json['employees_id'] as String?,
      requestDate: json['request_date'] as String?,
      type: json['type'] as String?,
      fromDate: json['from_date'] as String?,
      toDate: json['to_date'] as String?,
      days: json['days'] as String?,
      status: json['status'] as String?,
      requestNotes: json['request_notes'] as String?,
      statusNotes: json['status_notes'] as String?,
      createdBy: (json['created_by'] as num?)?.toInt(),
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HolidayRequestToJson(HolidayRequest instance) =>
    <String, dynamic>{
      'branches_id': ?instance.branchesId,
      'employees_id': ?instance.employeesId,
      'request_date': ?instance.requestDate,
      'type': ?instance.type,
      'from_date': ?instance.fromDate,
      'to_date': ?instance.toDate,
      'days': ?instance.days,
      'status': ?instance.status,
      'request_notes': ?instance.requestNotes,
      'status_notes': ?instance.statusNotes,
      'created_by': ?instance.createdBy,
      'updated_at': ?instance.updatedAt,
      'created_at': ?instance.createdAt,
      'id': ?instance.id,
    };
