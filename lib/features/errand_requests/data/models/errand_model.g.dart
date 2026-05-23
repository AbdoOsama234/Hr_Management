// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'errand_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrandModel _$ErrandModelFromJson(Map<String, dynamic> json) => ErrandModel(
  id: (json['id'] as num?)?.toInt(),
  companyId: (json['company_id'] as num?)?.toInt(),
  requestNumber: json['request_number'] as String?,
  requestDate: json['request_date'] as String?,
  tripType: json['trip_type'] as String?,
  employeesId: (json['employees_id'] as num?)?.toInt(),
  alternateEmployeeId: json['alternate_employee_id'] as String?,
  managementId: json['management_id'] as String?,
  branchesId: (json['branches_id'] as num?)?.toInt(),
  fromDate: json['from_date'] as String?,
  toDate: json['to_date'] as String?,
  daysCount: (json['days_count'] as num?)?.toInt(),
  status: json['status'] as String?,
  requestNotes: json['request_notes'] as String?,
  statusNotes: json['status_notes'] as String?,
  deletedAt: json['deleted_at'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  createdBy: (json['created_by'] as num?)?.toInt(),
  updatedBy: (json['updated_by'] as num?)?.toInt(),
  deletedBy: (json['deleted_by'] as num?)?.toInt(),
  merchantId: json['merchant_id'] as String?,
);

Map<String, dynamic> _$ErrandModelToJson(ErrandModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'company_id': ?instance.companyId,
      'request_number': ?instance.requestNumber,
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
      'deleted_at': ?instance.deletedAt,
      'created_at': ?instance.createdAt,
      'updated_at': ?instance.updatedAt,
      'created_by': ?instance.createdBy,
      'updated_by': ?instance.updatedBy,
      'deleted_by': ?instance.deletedBy,
      'merchant_id': ?instance.merchantId,
    };

AllErrand _$AllErrandFromJson(Map<String, dynamic> json) => AllErrand(
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  missions: (json['missions'] as List<dynamic>?)
      ?.map((e) => ErrandModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AllErrandToJson(AllErrand instance) => <String, dynamic>{
  'pagination': ?instance.pagination?.toJson(),
  'missions': ?instance.missions?.map((e) => e.toJson()).toList(),
};
