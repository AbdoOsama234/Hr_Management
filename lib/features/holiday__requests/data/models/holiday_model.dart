import 'package:json_annotation/json_annotation.dart';

import '../../../../data/models/pagination_model.dart';

part 'holiday_model.g.dart';

/// 🔹 Single Item
@JsonSerializable()
class HolidayModel {
  int? id;
  int? companyId;
  String? requestNumber;
  int? branchesId;
  int? employeesId;
  String? managementId;
  String? requestDate;
  String? type;
  String? fromDate;
  String? toDate;
  String? days;
  String? status;
  String? requestNotes;
  String? statusNotes;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  String? deletedAt;
  String? merchantId;

  HolidayModel({
    this.id,
    this.companyId,
    this.requestNumber,
    this.branchesId,
    this.employeesId,
    this.managementId,
    this.requestDate,
    this.type,
    this.fromDate,
    this.toDate,
    this.days,
    this.status,
    this.requestNotes,
    this.statusNotes,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.merchantId,
  });

  factory HolidayModel.fromJson(Map<String, dynamic> json) =>
      _$HolidayModelFromJson(json);

  Map<String, dynamic> toJson() => _$HolidayModelToJson(this);
}

@JsonSerializable()
class AllHolidays {
  Pagination? pagination;
  List<HolidayModel>? vacations;

  AllHolidays({this.pagination, this.vacations});

  factory AllHolidays.fromJson(Map<String, dynamic> json) =>
      _$AllHolidaysFromJson(json);

  Map<String, dynamic> toJson() => _$AllHolidaysToJson(this);
}
