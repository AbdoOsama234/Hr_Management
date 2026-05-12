import 'package:json_annotation/json_annotation.dart';

part 'holiday_request.g.dart';

/// 🔹 Single Item
@JsonSerializable()
class HolidayRequest {
  int? branchesId;
  String? employeesId;
  String? requestDate;
  String? type;
  String? fromDate;
  String? toDate;
  String? days;
  String? status;
  String? requestNotes;
  String? statusNotes;
  int? createdBy;
  String? updatedAt;
  String? createdAt;
  int? id;

  HolidayRequest({
    this.branchesId,
    this.employeesId,
    this.requestDate,
    this.type,
    this.fromDate,
    this.toDate,
    this.days,
    this.status,
    this.requestNotes,
    this.statusNotes,
    this.createdBy,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory HolidayRequest.fromJson(Map<String, dynamic> json) =>
      _$HolidayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HolidayRequestToJson(this);
}
