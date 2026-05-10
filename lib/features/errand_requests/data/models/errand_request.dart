import 'package:json_annotation/json_annotation.dart';

part 'errand_request.g.dart';

@JsonSerializable()
class ErrandRequest {
  final String? requestDate;
  final String? tripType;
  final String? employeesId;
  final String? alternateEmployeeId;
  final String? managementId;
  final int? branchesId;
  final String? fromDate;
  final String? toDate;
  final int? daysCount;
  final String? status;
  final String? requestNotes;
  final String? statusNotes;
  final int? createdBy;

  ErrandRequest({
    this.requestDate,
    this.tripType,
    this.employeesId,
    this.alternateEmployeeId,
    this.managementId,
    this.branchesId,
    this.fromDate,
    this.toDate,
    this.daysCount,
    this.status,
    this.requestNotes,
    this.statusNotes,
    this.createdBy,
  });

  factory ErrandRequest.fromJson(Map<String, dynamic> json) =>
      _$ErrandRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ErrandRequestToJson(this);
}
