import 'package:json_annotation/json_annotation.dart';

part 'permission_request.g.dart';

@JsonSerializable()
class PermissionRequest {
  @JsonKey(name: 'branches_id')
  int? branchesId;
  @JsonKey(name: 'employees_id')
  int? employeesId;
  @JsonKey(name: 'substitute_employee_id')
  int? substituteEmployeeId;
  @JsonKey(name: 'request_date')
  String? requestDate;
  String? type;
  @JsonKey(name: 'from_datetime')
  String? fromDatetime;
  @JsonKey(name: 'to_datetime')
  String? toDatetime;
  String? hours;
  String? status;
  @JsonKey(name: 'request_notes')
  String? requestNotes;
  @JsonKey(name: 'status_notes')
  String? statusNotes;
  @JsonKey(name: 'created_by')
  int? createdBy;

  PermissionRequest({
    this.branchesId,
    this.employeesId,
    this.substituteEmployeeId,
    this.requestDate,
    this.type,
    this.fromDatetime,
    this.toDatetime,
    this.hours,
    this.status,
    this.requestNotes,
    this.statusNotes,
    this.createdBy,
  });

  factory PermissionRequest.fromJson(Map<String, dynamic> json) =>
      _$PermissionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionRequestToJson(this);
}
