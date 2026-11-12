// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceRequest _$AttendanceRequestFromJson(Map<String, dynamic> json) =>
    AttendanceRequest(
      mode: json['mode'] as String? ?? 'check_in',
      employeeIds: (json['employee_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      dateFrom: json['date_from'] as String,
      dateTo: json['date_to'] as String,
      time: json['time'] as String,
      workingDaysOnly: json['working_days_only'] as bool? ?? false,
      overwrite: json['overwrite'] as bool? ?? false,
    );

Map<String, dynamic> _$AttendanceRequestToJson(AttendanceRequest instance) =>
    <String, dynamic>{
      'mode': instance.mode,
      'employee_ids': instance.employeeIds,
      'date_from': instance.dateFrom,
      'date_to': instance.dateTo,
      'time': instance.time,
      'working_days_only': instance.workingDaysOnly,
      'overwrite': instance.overwrite,
    };
