// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) =>
    AttendanceModel(
      id: (json['id'] as num?)?.toInt(),
      companyId: (json['company_id'] as num?)?.toInt(),
      employeesId: (json['employees_id'] as num?)?.toInt(),
      employeesShiftsId: (json['employees_shifts_id'] as num?)?.toInt(),
      date: json['date'] as String?,
      firstIn: json['first_in'] as String?,
      lastOut: json['last_out'] as String?,
      totalWorkMinutes: (json['total_work_minutes'] as num?)?.toInt(),
      lateMinutes: (json['late_minutes'] as num?)?.toInt(),
      earlyLeaveMinutes: (json['early_leave_minutes'] as num?)?.toInt(),
      overtimeMinutes: (json['overtime_minutes'] as num?)?.toInt(),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      firstOut: json['first_out'] as String?,
      secondIn: json['second_in'] as String?,
      merchantId: json['merchant_id'] as String?,
    );

Map<String, dynamic> _$AttendanceModelToJson(AttendanceModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'company_id': ?instance.companyId,
      'employees_id': ?instance.employeesId,
      'employees_shifts_id': ?instance.employeesShiftsId,
      'date': ?instance.date,
      'first_in': ?instance.firstIn,
      'last_out': ?instance.lastOut,
      'total_work_minutes': ?instance.totalWorkMinutes,
      'late_minutes': ?instance.lateMinutes,
      'early_leave_minutes': ?instance.earlyLeaveMinutes,
      'overtime_minutes': ?instance.overtimeMinutes,
      'status': ?instance.status,
      'created_at': ?instance.createdAt,
      'updated_at': ?instance.updatedAt,
      'first_out': ?instance.firstOut,
      'second_in': ?instance.secondIn,
      'merchant_id': ?instance.merchantId,
    };
