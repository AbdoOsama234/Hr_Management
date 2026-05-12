// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HolidayModel _$HolidayModelFromJson(Map<String, dynamic> json) => HolidayModel(
  id: (json['id'] as num?)?.toInt(),
  companyId: (json['company_id'] as num?)?.toInt(),
  requestNumber: json['request_number'] as String?,
  branchesId: (json['branches_id'] as num?)?.toInt(),
  employeesId: json['employees_id'] as String?,
  managementId: json['management_id'] as String?,
  requestDate: json['request_date'] as String?,
  type: json['type'] as String?,
  fromDate: json['from_date'] as String?,
  toDate: json['to_date'] as String?,
  days: json['days'] as String?,
  status: json['status'] as String?,
  requestNotes: json['request_notes'] as String?,
  statusNotes: json['status_notes'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  createdBy: (json['created_by'] as num?)?.toInt(),
  updatedBy: (json['updated_by'] as num?)?.toInt(),
  deletedBy: (json['deleted_by'] as num?)?.toInt(),
  deletedAt: json['deleted_at'] as String?,
  merchantId: json['merchant_id'] as String?,
);

Map<String, dynamic> _$HolidayModelToJson(HolidayModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'company_id': ?instance.companyId,
      'request_number': ?instance.requestNumber,
      'branches_id': ?instance.branchesId,
      'employees_id': ?instance.employeesId,
      'management_id': ?instance.managementId,
      'request_date': ?instance.requestDate,
      'type': ?instance.type,
      'from_date': ?instance.fromDate,
      'to_date': ?instance.toDate,
      'days': ?instance.days,
      'status': ?instance.status,
      'request_notes': ?instance.requestNotes,
      'status_notes': ?instance.statusNotes,
      'created_at': ?instance.createdAt,
      'updated_at': ?instance.updatedAt,
      'created_by': ?instance.createdBy,
      'updated_by': ?instance.updatedBy,
      'deleted_by': ?instance.deletedBy,
      'deleted_at': ?instance.deletedAt,
      'merchant_id': ?instance.merchantId,
    };

AllHolidays _$AllHolidaysFromJson(Map<String, dynamic> json) => AllHolidays(
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  vacations: (json['vacations'] as List<dynamic>?)
      ?.map((e) => HolidayModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AllHolidaysToJson(AllHolidays instance) =>
    <String, dynamic>{
      'pagination': ?instance.pagination?.toJson(),
      'vacations': ?instance.vacations?.map((e) => e.toJson()).toList(),
    };
