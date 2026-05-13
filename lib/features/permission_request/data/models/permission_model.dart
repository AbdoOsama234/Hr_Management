import 'package:json_annotation/json_annotation.dart';

part 'permission_model.g.dart';

@JsonSerializable()
class PermissionModel {
  int? id;
  @JsonKey(name: 'company_id')
  int? companyId;
  @JsonKey(name: 'request_number')
  String? requestNumber;
  @JsonKey(name: 'branches_id')
  int? branchesId;
  @JsonKey(name: 'request_date')
  String? requestDate;
  String? type;
  @JsonKey(name: 'employees_id')
  int? employeesId;
  @JsonKey(name: 'substitute_employee_id')
  int? substituteEmployeeId;
  @JsonKey(name: 'management_id')
  int? managementId;
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

  PermissionModel({
    this.id,
    this.companyId,
    this.requestNumber,
    this.branchesId,
    this.requestDate,
    this.type,
    this.employeesId,
    this.substituteEmployeeId,
    this.managementId,
    this.fromDatetime,
    this.toDatetime,
    this.hours,
    this.status,
    this.requestNotes,
    this.statusNotes,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) =>
      _$PermissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionModelToJson(this);
}
