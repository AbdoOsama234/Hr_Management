import 'package:json_annotation/json_annotation.dart';

part 'attendance_request_model.g.dart';

@JsonSerializable()
class AttendanceRequest {
  @JsonKey(defaultValue: 'check_in')
  final String mode;

  @JsonKey(name: 'employee_ids')
  final List<String> employeeIds;

  @JsonKey(name: 'date_from')
  final String dateFrom;

  @JsonKey(name: 'date_to')
  final String dateTo;

  final String time;

  @JsonKey(name: 'working_days_only')
  final bool workingDaysOnly;

  final bool overwrite;

  const AttendanceRequest({
    this.mode = 'check_in',
    required this.employeeIds,
    required this.dateFrom,
    required this.dateTo,
    required this.time,
    this.workingDaysOnly = false,
    this.overwrite = false,
  });

  factory AttendanceRequest.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceRequestToJson(this);
}
